From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 11 Aug 2013 08:15:56 +1200
Subject: [RFC PATCH] imx: video: staging: Add HDMI support to imx-drm
 driver
In-Reply-To: <CAOMZO5CGpdD-iSVBc_dCvCFPXnRuP8PEBRi=xUEcOGwNubX3GQ@mail.gmail.com>
References: <1375645673-18237-1-git-send-email-linux@prisktech.co.nz>
 <CAOMZO5CGpdD-iSVBc_dCvCFPXnRuP8PEBRi=xUEcOGwNubX3GQ@mail.gmail.com>
Message-ID: <52069F7C.9050600@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/08/13 05:52, Fabio Estevam wrote:
> Hi Tony,
>
> On Sun, Aug 4, 2013 at 4:47 PM, Tony Prisk <linux@prisktech.co.nz> wrote:
>> Add support for the HDMI controller found on the i.MX6. Driver is
>> based on code originally added by Sascha Hauer, but not submitted
>> to mainline/staging with the rest of the driver.
>>
>> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
>> ---
>>
>> This is a tidy up of Sascha's earlier HDMI driver for the staging/imx-drm
>> driver. It is still missing CEA support, but has tested fine on a Wandboard
>> Quad (and possibly the Dual?).
>>
>> This is a RFC to see how people feel about the state of the code for inclusion
>> into the mainline staging driver and what still needs to be done to get it
>> there.
>>
>> I have tidied up a lot of the unneccessary code that isn't used and added
>> some proper OF-related stuff.
> Thanks for working on this.
>
>> Regards
>> Tony Prisk
>>
>>   arch/arm/boot/dts/imx6dl-wandboard.dts      |   13 +
>>   arch/arm/boot/dts/imx6q-wandboard.dts       |   13 +
>>   arch/arm/boot/dts/imx6qdl.dtsi              |   10 +
> Please split the dts changes from the driver changes.
>
> The driver changes should go via Greg Kroah-Hartman staging tree.
>
> Once it is accepted, then you could submit the dts changes into Shawn's tree.
>
> I made some comments below (mostly comestic). After you take care of
> them, please send a formal patch to gregkh and
> devel at driverdev.osuosl.org (and also the folks you have Cc'ed here).
>
> ...
>
Thanks for the review.. Most of this is expected. I hadn't spent a lot 
of time tidying up or 'formalizing' the patch, but I will tidy up the 
comments you made.

Three problem's I have noticed with the driver are:

1) If I start the system with no output connected, then connect the 
hdmi, the framebuffer is initialized in 1024x768, but the 
connector/encoder is in 1920x1080 (as per the video= kernel param).

2) The PLL fails to lock several times during startup, but always seems 
to be ok to initialize the actually requested mode.

3) EDID reading fails occassionally for no obvious reason. Powering down 
the Wandboard (sometimes several times) and it comes right.

Once I get all this sorted out, and the code tidied up properly I will 
send a 'proper' patch.

Regards
Tony P
