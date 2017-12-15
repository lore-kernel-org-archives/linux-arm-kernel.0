From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Fri, 15 Dec 2017 16:55:17 +0100
Subject: [PATCH] arm64: rockchip: enable Rockchip IO domain support
In-Reply-To: <DB44D3E4-2CB5-452E-BE79-982225CB9E8F@theobroma-systems.com>
References: <20171215122010.34160-1-klaus.goger@theobroma-systems.com>
 <2479039.bQBttOkD7L@diego>
 <DB44D3E4-2CB5-452E-BE79-982225CB9E8F@theobroma-systems.com>
Message-ID: <8456682.qhFfChmmK7@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Dezember 2017, 16:51:39 CET schrieb klaus.goger at theobroma-
systems.com:
> > On 15.12.2017, at 16:33, Heiko St?bner <heiko@sntech.de> wrote:
> > 
> > Am Freitag, 15. Dezember 2017, 13:20:10 CET schrieb Klaus Goger:
> >> Make sure the IO domain support is active. This requires to enable
> >> Adaptive Voltage Scaling class support too.
> >> 
> >> Without Rockchip IO domain support the internal level shifter on the
> >> RK3399
> >> will be misconfigured if used in the other voltage domain then the
> >> default.
> >> 
> >> Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
> >> 
> >> ---
> >> 
> >> arch/arm64/Kconfig.platforms | 2 ++
> >> 1 file changed, 2 insertions(+)
> >> 
> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> >> index 2401373565ff..7c0b0ab12f18 100644
> >> --- a/arch/arm64/Kconfig.platforms
> >> +++ b/arch/arm64/Kconfig.platforms
> >> @@ -150,6 +150,8 @@ config ARCH_ROCKCHIP
> >> 
> >> 	select GPIOLIB
> >> 	select PINCTRL
> >> 	select PINCTRL_ROCKCHIP
> >> 
> >> +	select POWER_AVS
> >> +	select ROCKCHIP_IODOMAIN
> > 
> > I'm not sure if we really want this in the default arch Kconfig or if
> > there
> > are cases where the iodomain driver is not necessary.
> > 
> > On arm32 it just gets selected in the regular defconfig [0]
> 
> At least all currently supported 64bit Rockchip SoCs do have matching VSEL
> GRF settings. For me it looked essential enough to enable for all as not
> setting the correct I/O voltage will result in no output signal at all.
> But I?m fine with a defconfig change if that?s the way to go.
> Should I resend a patch or wait for other opinions?

Personally I would go with a defconfig change. I'd really like to keep the 
kconfig stuff minimal and at least all arm64 Rockchip boards can at least
boot without the iodomain driver.


Heiko
