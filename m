From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Aug 2013 13:06:17 -0300
Subject: [RFC PATCH] imx: video: staging: Add HDMI support to imx-drm
 driver
In-Reply-To: <52069F7C.9050600@prisktech.co.nz>
References: <1375645673-18237-1-git-send-email-linux@prisktech.co.nz>
 <CAOMZO5CGpdD-iSVBc_dCvCFPXnRuP8PEBRi=xUEcOGwNubX3GQ@mail.gmail.com>
 <52069F7C.9050600@prisktech.co.nz>
Message-ID: <CAOMZO5C43-wD65xHrenEbiD=6z-1+Mro95MOJELUhrqcTYABXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Sat, Aug 10, 2013 at 5:15 PM, Tony Prisk <linux@prisktech.co.nz> wrote:

> Thanks for the review.. Most of this is expected. I hadn't spent a lot of
> time tidying up or 'formalizing' the patch, but I will tidy up the comments
> you made.
>
> Three problem's I have noticed with the driver are:
>
> 1) If I start the system with no output connected, then connect the hdmi,
> the framebuffer is initialized in 1024x768, but the connector/encoder is in
> 1920x1080 (as per the video= kernel param).
>
> 2) The PLL fails to lock several times during startup, but always seems to
> be ok to initialize the actually requested mode.
>
> 3) EDID reading fails occassionally for no obvious reason. Powering down the
> Wandboard (sometimes several times) and it comes right.

Could it be that the DDC pull-up resistors are out of spec on Wandboard?

According to this datasheet (Table 3) :
http://www.nxp.com/documents/data_sheet/PCA9507.pdf

the SDA/SCL pull ups should be between 1.5k - 2.0k.

On Wandboard these pullups are 2.2k.

>
> Once I get all this sorted out, and the code tidied up properly I will send
> a 'proper' patch.

Understood.

Even though the three issues are still present, IMHO is still worth
submitting your patch, as the drivers in 'staging' directory are known
to be in initial development phase.

Regards,

Fabio Estevam
