From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 6 Mar 2012 14:04:46 +0800
Subject: [PATCH 0/2] Remove bq24022 driver superseeded by gpio-regulator
In-Reply-To: <201203021355.21669.heiko@sntech.de>
References: <201203021355.21669.heiko@sntech.de>
Message-ID: <CAN1soZwTR=j6=Xi-WKSTQwkGu+58pePb1syD+2q0UhHUJnfg_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2012 at 8:55 PM, Heiko St?bner <heiko@sntech.de> wrote:
> The bq24022 regulator is simply a more specialised variant of the now
> present gpio-regulator. Therefore it probably shouldn't stay around.
>
> This series converts the two users of bq24022 pxa/hx4700 and
> pxa/magician to use the gpio-regulator instead, and after this removes
> the then unused bq24022 driver.
>
> The series was compile-tested only, but the gpio-regulator itself is
> sucessfully used on my platform for the dcdc3 of a tps650240 (voltage
> regulator with one gpio) and for a bq24075 (current regulator with two
> gpios). So I'm quite sure it should work correctly but would welcome
> testers :-) .
>
> Heiko Stuebner (2):
> ?pxa: magician/hx4700: Convert to gpio-regulator from bq24022
> ?regulator: Remove bq24022 regulator driver
>
> ?arch/arm/configs/magician_defconfig | ? ?2 +-
> ?arch/arm/mach-pxa/hx4700.c ? ? ? ? ?| ? 33 ++++++--
> ?arch/arm/mach-pxa/magician.c ? ? ? ?| ? 33 ++++++--
> ?drivers/regulator/Kconfig ? ? ? ? ? | ? ?8 --
> ?drivers/regulator/Makefile ? ? ? ? ?| ? ?1 -
> ?drivers/regulator/bq24022.c ? ? ? ? | ?162 -----------------------------------
> ?include/linux/regulator/bq24022.h ? | ? 24 -----
> ?7 files changed, 55 insertions(+), 208 deletions(-)
> ?delete mode 100644 drivers/regulator/bq24022.c
> ?delete mode 100644 include/linux/regulator/bq24022.h
>
> --
Hi Mark,

I'm planning to merge this patch into arch-pxa tree since some changes
on hx4700.c and magician.c. Is it ok fot you?

Best Regards
Haojian
