From: B35083@freescale.com (Lu Jingchang-B35083)
Date: Tue, 23 Apr 2013 10:09:46 +0000
Subject: [PATCH 3/3] pinctrl: add MVF pinctrl driver
In-Reply-To: <20130422145727.GA27475@S2101-09.ap.freescale.net>
References: <1365753432-14247-1-git-send-email-b35083@freescale.com>
 <20130422145727.GA27475@S2101-09.ap.freescale.net>
Message-ID: <B56CDBE15CE27145A4B77D2D24263E851B17D9@039-SN1MPN1-003.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>-----Original Message-----
>From: Shawn Guo [mailto:shawn.guo at linaro.org]
>Sent: Monday, April 22, 2013 10:57 PM
>To: Lu Jingchang-B35083
>Cc: linux-arm-kernel at lists.infradead.org; linus.walleij at linaro.org
>Subject: Re: [PATCH 3/3] pinctrl: add MVF pinctrl driver
>
>On Fri, Apr 12, 2013 at 03:57:12PM +0800, Jingchang Lu wrote:
>> It adds Freescale Vybrid Family pin controller driver to I.MX IOMUXC
>> common driver architecture.
>> The only difference is the MUX and CONF register is the same on MVF
>> platform, so the defined config value including the mux_mode int DTS.
>>
>This make no sense.  We should patch pinctrl-imx driver to support MVF.
>
[Lu Jingchang-B35083] 
i.mx and MVF platform have difference register definition for IOMUXC. On i.mx there are two registers for mux_mode and control value, But on MVF platform there is only one register. I'll try to investigate your new IMX pinctrl framework and try to patch it to support the MVF platform. Thanks.

>> Signed-off-by: Jingchang Lu <b35083@freescale.com>
>> ---
>>  .../bindings/pinctrl/fsl,mvf-pinctrl.txt           |  825 ++++++++
>>  drivers/pinctrl/Kconfig                            |    8 +
>>  drivers/pinctrl/Makefile                           |    1 +
>>  drivers/pinctrl/pinctrl-mvf.c                      | 2042
>++++++++++++++++++++
>
>We just removed those big arrays of imx_pin_reg from imx pinctrl soc
>drivers.  Please do not bring it back for MVF.
>
[Lu Jingchang-B35083] 
What's the status of your new i.mx pinctrl framework? I found that there are some discussion for that, Are they accepted? Where can I find the latest code so I can use it as the base for MVF platform? Thanks.


>Shawn
