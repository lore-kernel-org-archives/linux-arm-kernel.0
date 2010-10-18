From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 18 Oct 2010 22:45:10 +0900
Subject: [PATCH 3/9] ARM: S3C64XX: add touchscreen support for
	mach-real6410
In-Reply-To: <AANLkTin0zOj+PnTe8JKNRmyQ-gVvYZRcJwcA2Pu+P4h7@mail.gmail.com>
References: <20100929192354.25307.40197.stgit@darius-desktop>
	<20100929193322.25307.67196.stgit@darius-desktop>
	<04a501cb6ec8$7e719a80$7b54cf80$%kim@samsung.com>
	<AANLkTin0zOj+PnTe8JKNRmyQ-gVvYZRcJwcA2Pu+P4h7@mail.gmail.com>
Message-ID: <04a701cb6eca$b0bd5b80$12381280$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Darius Augulis wrote:
> 
> On Mon, Oct 18, 2010 at 4:29 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Darius Augulis wrote:
> >>
> >> Add touchscreen device support for mach-real6410
> >>
> >> Signed-off-by: Darius Augulis <augulis.darius@gmail.com>
> >> ---
> >> ?arch/arm/mach-s3c64xx/Kconfig ? ? ? ? | ? ?2 ++
> >> ?arch/arm/mach-s3c64xx/mach-real6410.c | ? 11 +++++++++++
> >> ?2 files changed, 13 insertions(+), 0 deletions(-)
> >>
> >> diff --git a/arch/arm/mach-s3c64xx/Kconfig
b/arch/arm/mach-s3c64xx/Kconfig
> >> index e4aede1..b706b80 100644
> >> --- a/arch/arm/mach-s3c64xx/Kconfig
> >> +++ b/arch/arm/mach-s3c64xx/Kconfig
> >> @@ -107,6 +107,8 @@ config MACH_REAL6410
> >> ? ? ? select S3C_DEV_FB
> >> ? ? ? select S3C64XX_SETUP_FB_24BPP
> >> ? ? ? select S3C_DEV_NAND
> >> + ? ? select SAMSUNG_DEV_ADC
> >> + ? ? select SAMSUNG_DEV_TS
> >> ? ? ? help
> >> ? ? ? ? Machine support for the CoreWind REAL6410
> >>
> >> diff --git a/arch/arm/mach-s3c64xx/mach-real6410.c b/arch/arm/mach-
> >> s3c64xx/mach-real6410.c
> >> index 9fd943d..bad6990 100644
> >> --- a/arch/arm/mach-s3c64xx/mach-real6410.c
> >> +++ b/arch/arm/mach-s3c64xx/mach-real6410.c
> >> @@ -36,11 +36,13 @@
> >> ?#include <mach/regs-srom.h>
> >> ?#include <mach/s3c6410.h>
> >>
> >> +#include <plat/adc.h>
> >> ?#include <plat/cpu.h>
> >> ?#include <plat/devs.h>
> >> ?#include <plat/fb.h>
> >> ?#include <plat/nand.h>
> >> ?#include <plat/regs-serial.h>
> >> +#include <plat/ts.h>
> >>
> >> ?#include <video/platform_lcd.h>
> >>
> >> @@ -191,6 +193,14 @@ static struct platform_device *real6410_devices[]
> >> __initdata = {
> >> ? ? ? &s3c_device_hsmmc1,
> >> ? ? ? &s3c_device_fb,
> >> ? ? ? &s3c_device_nand,
> >> + ? ? &s3c_device_adc,
> >> + ? ? &s3c_device_ts,
> >> +};
> >> +
> >> +static struct s3c2410_ts_mach_info s3c_ts_platform __initdata = {
> >> + ? ? .delay ? ? ? ? ? ? ? ? ?= 10000,
> >> + ? ? .presc ? ? ? ? ? ? ? ? ?= 49,
> >> + ? ? .oversampling_shift ? ? = 2,
> >> ?};
> >>
> >> ?static void __init real6410_map_io(void)
> >> @@ -289,6 +299,7 @@ static void __init real6410_machine_init(void)
> >>
> >> ? ? ? s3c_fb_set_platdata(&real6410_lcd_pdata);
> >> ? ? ? s3c_nand_set_platdata(&real6410_nand_info);
> >> + ? ? s3c24xx_ts_set_platdata(&s3c_ts_platform);
> >>
> >> ? ? ? /* configure nCS1 width to 16 bits */
> >>
> >
> > No need to add 's3c_adc_setname("s3c64xx-adc")' in mach-s3c64xx?
> 
> IMO no, because it's called from s3c6410_map_io() which is generic for
> all s3c64xx boards.
> This patch selects  SAMSUNG_DEV_ADC and this is enough.
> btw, all patches are tested and all devices work ok.
> 
Oh, yes...I mis-typed to find it...
Maybe I need sleeping, hehe ;-)

Will check to continue...your patches tomorrow morning.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
