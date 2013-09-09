From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 9 Sep 2013 11:19:22 -0500
Subject: [PATCH 1/2] ARM: dts: mx6: Add mx6solo support
In-Reply-To: <CAOMZO5Ab9qVsQica-x3091YPhttqpbr_NL=A2ddzL5znuDtAUw@mail.gmail.com>
References: <1378688408-8689-1-git-send-email-festevam@gmail.com>
 <20130909150823.GB5815@S2101-09.ap.freescale.net>
 <CAOMZO5Ab9qVsQica-x3091YPhttqpbr_NL=A2ddzL5znuDtAUw@mail.gmail.com>
Message-ID: <CAOCHtYhJjxBL1AY0dxc+FofXqRT25g8yaO+Z6d09mfkJWT+i+A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 9, 2013 at 10:59 AM, Fabio Estevam <festevam@gmail.com> wrote:
> On Mon, Sep 9, 2013 at 12:08 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> On Sun, Sep 08, 2013 at 10:00:07PM -0300, Fabio Estevam wrote:
>>> From: Fabio Estevam <fabio.estevam@freescale.com>
>>>
>>> Allow booting a device tree kernel on mx6solo.
>>>
>>> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
>>> ---
>>>  arch/arm/boot/dts/imx6s.dtsi   | 82 ++++++++++++++++++++++++++++++++++++++++++
>>
>> The imx6s is not another SoC but just imx6dl with one core fused out.
>> This is the exactly same case as imx6q and imx6d. See commit dc13ba2
>> (ARM: imx: do not bring up unavailable cores) for how we handle that
>> in kernel.
>>
>> Are you running into any problem to boot imx6s wandboard with
>> imx6dl-wandboard.dtb?
>
> Ok, I made this test and it booted fine.
>
> So I will change U-boot so that it searches for imx6dl-wandboard.dtb
> instead of imx6s-wandboard.dtb.

Since there is no WiFi/Bluetooth on the "solo" vs the wandboard dual
lite, we should really still have a separate solo dtb file..

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
