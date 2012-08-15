From: alanbutty12@gmail.com (alan butler)
Date: Wed, 15 Aug 2012 20:56:29 +0000
Subject: PATCH Add support for the Iomega IX2-200 Device Tree
In-Reply-To: <20120815201949.GI22226@titan.lakedaemon.net>
References: <3CAEA3DD-9D2C-4052-957D-D09E6EB9B64E@gmail.com>
 <20120814235653.GA22226@titan.lakedaemon.net>
 <95D5BE56-A79F-4422-B1CE-7AD010A9D70E@gmail.com>
 <20120815111209.GB22226@titan.lakedaemon.net>
 <CAMW5Ufb-8NrWu6vsJ+RezrLEGj-Wfm5Tc+0BK9_2qzn671FrpQ@mail.gmail.com>
 <20120815121145.GC22226@titan.lakedaemon.net>
 <CADhrpJ4-4n15yfttBBFQOdOkKag0gaeqYgB4DFre3aG+R4Vq+Q@mail.gmail.com>
 <20120815135427.GF22226@titan.lakedaemon.net>
 <CADhrpJ5JEGQWAjwu5+=Hy_gFjWLkkrzj9E0dZ-vxMk9x+M5uCA@mail.gmail.com>
 <20120815201949.GI22226@titan.lakedaemon.net>
Message-ID: <CADhrpJ4kqpxJrBFPD4o=B3ni=ZUX3EdjBW30k9HxazEB75RMPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 August 2012 21:19, Jason Cooper <jason@lakedaemon.net> wrote:
> Alan,
>
> Not too bad for your first go-round with git.  Some comments below.
>
>
> On Wed, Aug 15, 2012 at 07:00:42PM +0100, alan butler wrote:
> ...
>> i did what you sujested and all commands worked except for the git
>> sendmail part so i do not know if I should still be sending you the
>> patch this way but here it is.
>
> Please post the exact command you used and the complete error message it
> gave you.
>
>> i also defined the gpio keys in the dts
>> file like you said the same as with the iconnect but the kernel keeps
>> crashing with them defined in the dts is the support actualy there for
>> the keys? or have i just defined them wrong?
>
> Please post the exact error message from the kernel for this as well.
>
>>
>> From f55ed67347f4b10ebbe2adc29d134acaf362279a Mon Sep 17 00:00:00 2001
>> Message-Id: <cover.1345046444.git.alanbutty12@gmail.com>
>> From: Alan M Butler <alanbutty12@gmail.com>
>> Date: Wed, 15 Aug 2012 17:00:44 +0100
>> Subject: [PATCH] *** SUBJECT HERE ***
>>
>> *** BLURB HERE ***
>
> Since this is a single patch, not a series, you can omit --cover-letter.
>
>> Alan M Butler (1):
>>   ARM: Kirkwood: Iomega_IX2_200     Signed-off-by: Alan M Butler
>>     <alanbutty12@gmail.com>
>>
>>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  111 +++++++++++++++++++++++++
>>  arch/arm/mach-kirkwood/Kconfig                |    7 ++
>>  arch/arm/mach-kirkwood/Makefile               |    1 +
>>  arch/arm/mach-kirkwood/Makefile.boot          |    1 +
>>  arch/arm/mach-kirkwood/board-dt.c             |    4 +
>>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   80 ++++++++++++++++++
>>  arch/arm/mach-kirkwood/common.h               |    6 ++
>>  7 files changed, 210 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>>  create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>>
>> --
>> 1.7.5.4
>> From f55ed67347f4b10ebbe2adc29d134acaf362279a Mon Sep 17 00:00:00 2001
>> Message-Id: <f55ed67347f4b10ebbe2adc29d134acaf362279a.1345046444.git.alanbutty12@gmail.com>
>> In-Reply-To: <cover.1345046444.git.alanbutty12@gmail.com>
>> References: <cover.1345046444.git.alanbutty12@gmail.com>
>> From: Alan M Butler <alanbutty12@gmail.com>
>> Date: Wed, 15 Aug 2012 16:52:56 +0100
>> Subject: [PATCH] ARM: Kirkwood: Iomega_IX2_200 Signed-off-by: Alan M Butler
>>  <alanbutty12@gmail.com>
>
> The 'git commit -s' automatically signs the commit properly.  So, you
> shouldn't have to add the Signed-off-by: anywhere once you have git
> send-email working.
>
> btw - vvvv these are the '---' I was referring to.
>
>> ---
>>  arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts |  111 +++++++++++++++++++++++++
>>  arch/arm/mach-kirkwood/Kconfig                |    7 ++
>>  arch/arm/mach-kirkwood/Makefile               |    1 +
>>  arch/arm/mach-kirkwood/Makefile.boot          |    1 +
>>  arch/arm/mach-kirkwood/board-dt.c             |    4 +
>>  arch/arm/mach-kirkwood/board-iomega_ix2_200.c |   80 ++++++++++++++++++
>>  arch/arm/mach-kirkwood/common.h               |    6 ++
>>  7 files changed, 210 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>>  create mode 100644 arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>>
>> diff --git a/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> new file mode 100644
>> index 0000000..7863009
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts
>> @@ -0,0 +1,111 @@
>> +/dts-v1/;
>> +
>> +/include/ "kirkwood.dtsi"
>> +
>> +/ {
>> +     model = "Iomega StorCenter ix2-200";
>> +     compatible = "iom,ix2-200", "marvell,kirkwood-88f6281", "marvell,kirkwood";
>> +
>> +     memory {
>> +             device_type = "memory";
>> +             reg = <0x00000000 0x10000000>;
>> +     };
>> +
>> +     chosen {
>> +             bootargs = "console=ttyS0,115200n8 earlyprintk";
>> +     };
>> +
>> +     ocp at f1000000 {
>> +             i2c at 11000 {
>> +                     status = "okay";
>> +
>> +                     lm63: lm63 at 4c {
>> +                             compatible = "national,lm63";
>> +                             reg = <0x4c>;
>> +                     };
>> +             };
>> +
>> +             serial at 12000 {
>> +                     clock-frequency = <200000000>;
>> +                     status = "ok";
>> +             };
>> +
>> +             nand at 3000000 {
>> +                     status = "okay";
>> +
>> +                     partition at 0 {
>> +                             label = "u-boot";
>> +                             reg = <0x0000000 0x100000>;
>> +                             read-only;
>> +                     };
>> +
>> +                     partition at a0000 {
>> +                             label = "env";
>> +                             reg = <0xa0000 0x20000>;
>> +                     };
>> +
>> +                     partition at 100000 {
>> +                             label = "uImage";
>> +                             reg = <0x100000 0x300000>;
>> +                             read-only;
>> +                     };
>> +
>> +                     partition at 400000 {
>> +                             label = "uInitrd";
>> +                             reg = <0x540000 0x1000000>;
>> +                     };
>> +             };
>> +             sata at 80000 {
>> +                     compatible = "marvell,orion-sata";
>> +                     reg = <0x80000 0x5000>;
>> +                     interrupts = <21>;
>> +                     status = "okay";
>> +                     nr-ports = <2>;
>> +             };
>> +
>> +     };
>> +     gpio-leds {
>> +             compatible = "gpio-leds";
>> +
>> +             power_led {
>> +                     label = "status:white:power_led";
>> +                     gpios = <&gpio0 16 0>;
>> +                     linux,default-trigger = "default-on";
>> +             };
>> +             rebuild_led {
>> +                     label = "status:white:rebuild_led";
>> +                     gpios = <&gpio1 5 0>;
>> +             };
>> +             health_led {
>> +                     label = "status:red:health_led";
>> +                     gpios = <&gpio1 6 0>;
>> +             };
>> +             backup_led {
>> +                     label = "status:blue:backup_led";
>> +                     gpios = <&gpio0 15 0>;
>> +             };
>> +     };
>> +     gpio_keys {
>> +             compatible = "gpio-keys";
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             button at 1 {
>> +                     label = "OTB Button";
>> +                     linux,code = <0x00>;
>> +                     gpios = <&gpio1 4 1>;
>> +                     debounce-interval = <100>;
>> +             };
>> +             button at 2 {
>> +                     label = "Reset";
>> +                     linux,code = <0x01>;
>> +                     gpios = <&gpio0 12 1>;
>> +                     debounce-interval = <100>;
>> +             };
>> +             button at 3 {
>> +                     label = "Power";
>> +                     linux,code = <0x028>;
>> +                     gpios = <&gpio0 14 1>;
>> +                     debounce-interval = <100>;
>> +             };
>> +     };
>> +};
>> diff --git a/arch/arm/mach-kirkwood/Kconfig b/arch/arm/mach-kirkwood/Kconfig
>> index ca5c15a..bee8451 100644
>> --- a/arch/arm/mach-kirkwood/Kconfig
>> +++ b/arch/arm/mach-kirkwood/Kconfig
>> @@ -195,6 +195,13 @@ config MACH_T5325
>>         Say 'Y' here if you want your kernel to support the
>>         HP t5325 Thin Client.
>>
>> +config MACH_IOMEGA_IX2_200_DT
>> +     bool "Iomega StorCenter ix2-200 (Flattened Device Tree)"
>> +     select ARCH_KIRKWOOD_DT
>> +     help
>> +       Say 'Y' here if you want your kernel to support the
>> +       Iomega StorCenter ix2-200 (Flattened Device Tree).
>> +
>>  endmenu
>>
>>  endif
>> diff --git a/arch/arm/mach-kirkwood/Makefile b/arch/arm/mach-kirkwood/Makefile
>> index 055c85a..f5484dc 100644
>> --- a/arch/arm/mach-kirkwood/Makefile
>> +++ b/arch/arm/mach-kirkwood/Makefile
>> @@ -28,3 +28,4 @@ obj-$(CONFIG_MACH_IB62X0_DT)                += board-ib62x0.o
>>  obj-$(CONFIG_MACH_TS219_DT)          += board-ts219.o tsx1x-common.o
>>  obj-$(CONFIG_MACH_GOFLEXNET_DT)              += board-goflexnet.o
>>  obj-$(CONFIG_MACH_LSXL_DT)           += board-lsxl.o
>> +obj-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += board-iomega_ix2_200.o
>> diff --git a/arch/arm/mach-kirkwood/Makefile.boot
>> b/arch/arm/mach-kirkwood/Makefile.boot
>> index 2a576ab..f8ef771 100644
>> --- a/arch/arm/mach-kirkwood/Makefile.boot
>> +++ b/arch/arm/mach-kirkwood/Makefile.boot
>> @@ -11,3 +11,4 @@ dtb-$(CONFIG_MACH_TS219_DT) += kirkwood-qnap-ts219.dtb
>>  dtb-$(CONFIG_MACH_GOFLEXNET_DT) += kirkwood-goflexnet.dtb
>>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lschlv2.dtb
>>  dbt-$(CONFIG_MACH_LSXL_DT) += kirkwood-lsxhl.dtb
>> +dtb-$(CONFIG_MACH_IOMEGA_IX2_200_DT) += kirkwood-iomega_ix2_200.dtb
>> diff --git a/arch/arm/mach-kirkwood/board-dt.c
>> b/arch/arm/mach-kirkwood/board-dt.c
>> index e4eb450..a932ae9 100644
>> --- a/arch/arm/mach-kirkwood/board-dt.c
>> +++ b/arch/arm/mach-kirkwood/board-dt.c
>> @@ -87,6 +87,9 @@ static void __init kirkwood_dt_init(void)
>>       if (of_machine_is_compatible("buffalo,lsxl"))
>>               lsxl_init();
>>
>> +     if (of_machine_is_compatible("iom,ix2-200"))
>> +             iomega_ix2_200_init()
>> +
>>       of_platform_populate(NULL, kirkwood_dt_match_table,
>>                            kirkwood_auxdata_lookup, NULL);
>>  }
>> @@ -100,6 +103,7 @@ static const char *kirkwood_dt_board_compat[] = {
>>       "qnap,ts219",
>>       "seagate,goflexnet",
>>       "buffalo,lsxl",
>> +     "iom,ix2-200",
>>       NULL
>>  };
>>
>> diff --git a/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> new file mode 100644
>> index 0000000..a6bb98e
>> --- /dev/null
>> +++ b/arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> @@ -0,0 +1,80 @@
>> +/*
>> + * arch/arm/mach-kirkwood/board-iomega_ix2_200.c
>> + *
>> + * Iomega StorCenter ix2-200
>> + *
>> + * This file is licensed under the terms of the GNU General Public
>> + * License version 2.  This program is licensed "as is" without any
>> + * warranty of any kind, whether express or implied.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/irq.h>
>> +#include <linux/mtd/partitions.h>
>> +#include <linux/ata_platform.h>
>> +#include <linux/mv643xx_eth.h>
>> +#include <linux/ethtool.h>
>> +#include <net/dsa.h>
>> +#include <linux/gpio.h>
>> +#include <linux/leds.h>
>> +#include <linux/i2c.h>
>> +#include <asm/mach-types.h>
>> +#include <asm/mach/arch.h>
>> +#include <mach/kirkwood.h>
>> +#include "common.h"
>> +#include "mpp.h"
>> +
>> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge00_data = {
>> +     .phy_addr       = MV643XX_ETH_PHY_NONE,
>> +     .speed          = SPEED_1000,
>> +     .duplex         = DUPLEX_FULL,
>> +};
>> +
>> +static struct mv643xx_eth_platform_data iomega_ix2_200_ge01_data = {
>> +     .phy_addr       = MV643XX_ETH_PHY_ADDR(11),
>> +};
>> +
>> +static unsigned int iomega_ix2_200_mpp_config[] __initdata = {
>> +     MPP12_GPIO,                     /* Reset Button */
>> +     MPP14_GPIO,                     /* Power Button */
>> +     MPP15_GPIO,                     /* Backup LED (blue) */
>> +     MPP16_GPIO,                     /* Power LED (white) */
>> +     MPP35_GPIO,                     /* OTB Button */
>> +     MPP36_GPIO,                     /* Rebuild LED (white) */
>> +     MPP37_GPIO,                     /* Health LED (red) */
>> +     MPP38_GPIO,                     /* SATA LED brightness control 1 */
>> +     MPP39_GPIO,                     /* SATA LED brightness control 2 */
>> +     MPP40_GPIO,                     /* Backup LED brightness control 1 */
>> +     MPP41_GPIO,                     /* Backup LED brightness control 2 */
>> +     MPP42_GPIO,                     /* Power LED brightness control 1 */
>> +     MPP43_GPIO,                     /* Power LED brightness control 2 */
>> +     MPP44_GPIO,                     /* Health LED brightness control 1 */
>> +     MPP45_GPIO,                     /* Health LED brightness control 2 */
>> +     MPP46_GPIO,                     /* Rebuild LED brightness control 1 */
>> +     MPP47_GPIO,                     /* Rebuild LED brightness control 2 */
>> +     0
>> +};
>> +
>> +void __init iomega_ix2_200_init(void)
>> +{
>> +     /*
>> +      * Basic setup. Needs to be called early.
>> +      */
>> +     kirkwood_mpp_conf(iomega_ix2_200_mpp_config);
>> +
>> +     kirkwood_ehci_init();
>> +
>> +     kirkwood_ge00_init(&iomega_ix2_200_ge00_data);
>> +     kirkwood_ge01_init(&iomega_ix2_200_ge01_data);
>> +}
>> +
>> +static int __init iomega_ix2_200_pci_init(void)
>> +{
>> +     if (of_machine_is_compatible("iom,ix2-200"))
>> +             kirkwood_pcie_init(KW_PCIE0);
>> +     return 0;
>> +}
>> +subsys_initcall(iomega_ix2_200_pci_init);
>> +
>> diff --git a/arch/arm/mach-kirkwood/common.h b/arch/arm/mach-kirkwood/common.h
>> index 304dd1a..d5d4064 100644
>> --- a/arch/arm/mach-kirkwood/common.h
>> +++ b/arch/arm/mach-kirkwood/common.h
>> @@ -94,6 +94,12 @@ void lsxl_init(void);
>>  static inline void lsxl_init(void) {};
>>  #endif
>>
>> +#ifdef CONFIG_MACH_IOMEGA_IX2_200_DT
>> +void iomega_ix2_200_init(void);
>> +#else
>> +static inline void iomega_ix2_200_init(void) {};
>> +#endif
>> +
>>  /* early init functions not converted to fdt yet */
>>  char *kirkwood_id(void);
>>  void kirkwood_l2_init(void);
>> Signed-off-by: Alan M Butler <alanbutty12@gmail.com>
>
> Please remove this line ^^^.  It isn't valid C ;-)  See my comment
> above.
>
> thx,
>
> Jason.
Thanks yeah first time using git first time trying to create a real
patch for linux (and learning how in the process) and trying to figure
out this device tree stuff.

As far as i can tell from looking at the iconnect button definition's
that part is correct (except for the proper codes to do what the
buttons should actually do) the error i get is:

[    5.976074] Key type dns_resolver registered
[    5.981782] Unable to handle kernel NULL pointer dereference at
virtual address 00000004
[    5.989932] pgd = c0004000
[    5.992649] [00000004] *pgd=00000000
[    5.996247] Internal error: Oops: 805 [#1] ARM
[    6.000707] Modules linked in:
[    6.003780] CPU: 0    Not tainted  (3.6.0-rc1-next-20120814 #13)
[    6.009822] PC is at gpio_keys_probe+0x110/0x6d4
[    6.014471] LR is at of_get_named_gpio_flags+0x90/0xb4
[    6.019634] pc : [<c02e3190>]    lr : [<c0191a80>]    psr: 60000013
[    6.019634] sp : cf82feb8  ip : 00000001  fp : cf867400
[    6.031158] r10: cf867408  r9 : 00000028  r8 : 00000000
[    6.036400] r7 : c07ebde0  r6 : c07ebe64  r5 : 00000000  r4 : ceff7600
[    6.042958] r3 : 00000001  r2 : c042e57c  r1 : 00000000  r0 : 00000023
[    6.049516] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[    6.056857] Control: 0005397f  Table: 0eff8000  DAC: 00000017
[    6.062629] Process swapper (pid: 1, stack limit = 0xcf82e270)
[    6.068481] Stack: (0xcf82feb8 to 0xcf830000)
[    6.072851] fea0:
    00000000 cefff380
[    6.081071] fec0: cf865b40 c00e88f8 cf84e080 00000000 cf808bac
00000003 cf865b40 00000001
[    6.089286] fee0: cf86743c cf867408 cf86743c c04476cc c04476cc
00000034 c041d318 c03fb208
[    6.097500] ff00: 00000000 c01c7ccc c01c7cb8 c01c6dc4 00000000
cf867408 cf86743c c04476cc
[    6.105713] ff20: 00000000 c01c6f5c c04476cc cf82ff38 c01c6efc
c01c58b4 cf808b8c cf8641b0
[    6.113928] ff40: c04476cc c04476cc ceffe300 c0442d18 00000000
c01c654c c03aa8b2 c03aa8b3
[    6.122141] ff60: c04476cc c0412e40 00000000 c0451300 00000034
c01c7208 00000000 00000007
[    6.130355] ff80: c0412e40 00000000 c0451300 00000034 c03fb208
c0008554 00000007 00000007
[    6.138570] ffa0: 00000000 00000007 c0419614 00000007 c0419618
c04195f8 c0451300 00000034
[    6.146784] ffc0: c041d318 c03fb894 00000007 00000007 c03fb208
00000000 00000000 c03fb77c
[    6.154999] ffe0: c000a004 00000013 00000000 00000000 00000000
c000a004 80040038 08040038
[    6.163226] [<c02e3190>] (gpio_keys_probe+0x110/0x6d4) from
[<c01c7ccc>] (platform_drv_probe+0x14/0x18)
[    6.172676] [<c01c7ccc>] (platform_drv_probe+0x14/0x18) from
[<c01c6dc4>] (driver_probe_device+0xb8/0x1f0)
[    6.182385] [<c01c6dc4>] (driver_probe_device+0xb8/0x1f0) from
[<c01c6f5c>] (__driver_attach+0x60/0x84)
[    6.191827] [<c01c6f5c>] (__driver_attach+0x60/0x84) from
[<c01c58b4>] (bus_for_each_dev+0x4c/0x78)
[    6.200922] [<c01c58b4>] (bus_for_each_dev+0x4c/0x78) from
[<c01c654c>] (bus_add_driver+0xa8/0x21c)
[    6.210017] [<c01c654c>] (bus_add_driver+0xa8/0x21c) from
[<c01c7208>] (driver_register+0x9c/0x138)
[    6.219112] [<c01c7208>] (driver_register+0x9c/0x138) from
[<c0008554>] (do_one_initcall+0x90/0x168)
[    6.228294] [<c0008554>] (do_one_initcall+0x90/0x168) from
[<c03fb894>] (kernel_init+0x118/0x1d8)
[    6.237215] [<c03fb894>] (kernel_init+0x118/0x1d8) from
[<c000a004>] (kernel_thread_exit+0x0/0x8)
[    6.246130] Code: e5945000 ebfaba19 e0255899 e59d3024 (e5850004)
[    6.252273] ---[ end trace 192fd8390b667beb ]---
[    6.256946] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b


and as for the git command i tried and what it tells me this is what i get:

git send-email --to="alanbutty12 at gmail.com" --smtp-server=Gmail
--no-chain-reply-to --from="alanbutty12 at gmail.com"
/tmp/patches/*.patch


error:
git: 'send-email' is not a git command. See 'git --help'.

I am using a ubuntu 11.10 vm to compile and do my patching and such on
if thats in any way useful.
