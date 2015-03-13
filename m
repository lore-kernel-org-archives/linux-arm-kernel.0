From: simon.guinot@sequanux.org (Simon Guinot)
Date: Fri, 13 Mar 2015 10:44:33 +0100
Subject: [PATCH 0/4] Allow to use leds-ns2 with n090401 boards
In-Reply-To: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
References: <1425480739-2373-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150313094433.GU1509@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 03:52:15PM +0100, Simon Guinot wrote:
> Hello,
> 
> This patch series allows to use the leds-ns2 driver with the n090401
> boards (Seagate NAS 4-Bay), based on an Armada-370 SoC.
> 
> Here is the list changes:
> 
> - Allow to configure the LED mode mapping.
> - Handle can_sleep GPIOs. On n090401, the LEDs are connected to an I2C
>   GPIO expander.
> - Make leds-ns2 depends on MACH_ARMADA_370.

Hi Brian,

Please consider applying the leds-ns2 patches of this serie.

Thanks in advance.

Simon

> Simon Guinot (2):
>   leds: leds-ns2: handle can_sleep GPIOs
>   leds: leds-ns2: depends on MACH_ARMADA_370
> 
> Vincent Donnefort (2):
>   leds: leds-ns2: move LED modes mapping outside of the driver
>   ARM: Kirkwood: add modes-map property to ns2-leds nodes
> 
>  .../devicetree/bindings/leds/leds-ns2.txt          |   9 ++
>  arch/arm/boot/dts/kirkwood-d2net.dts               |   5 +
>  arch/arm/boot/dts/kirkwood-is2.dts                 |   5 +
>  arch/arm/boot/dts/kirkwood-ns2.dts                 |   5 +
>  arch/arm/boot/dts/kirkwood-ns2max.dts              |   5 +
>  arch/arm/boot/dts/kirkwood-ns2mini.dts             |   5 +
>  drivers/leds/Kconfig                               |  12 +-
>  drivers/leds/leds-ns2.c                            | 156 +++++++++++++--------
>  include/dt-bindings/leds/leds-ns2.h                |   8 ++
>  include/linux/platform_data/leds-kirkwood-ns2.h    |  14 ++
>  10 files changed, 159 insertions(+), 65 deletions(-)
>  create mode 100644 include/dt-bindings/leds/leds-ns2.h
> 
> -- 
> 2.1.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150313/2f153504/attachment.sig>
