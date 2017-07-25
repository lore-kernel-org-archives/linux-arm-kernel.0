From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 25 Jul 2017 21:17:16 +0800
Subject: [PATCH v4 2/2] ARM: dts: imx: add CX9020 Embedded PC device tree
In-Reply-To: <3BB206AB2B1BD448954845CE6FF69A8E0182B4CFE8@nt-mail04>
References: <20170712090408.12212-1-linux-kernel-dev@beckhoff.com>
 <20170721040640.31424-1-linux-kernel-dev@beckhoff.com>
 <20170721040640.31424-3-linux-kernel-dev@beckhoff.com>
 <20170725075934.GA20064@dragon>
 <3BB206AB2B1BD448954845CE6FF69A8E0182B4CFE8@nt-mail04>
Message-ID: <20170725131715.GA29754@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 25, 2017 at 11:41:56AM +0000, Patrick Br?nn wrote:
> >From: Shawn Guo [mailto:shawnguo at kernel.org]
> >On Fri, Jul 21, 2017 at 06:06:40AM +0200, linux-kernel-dev at beckhoff.com
> >wrote:
> >> From: Patrick Bruenn <p.bruenn@beckhoff.com>
> >>
> >> The CX9020 differs from i.MX53 Quick Start Board by:
> >> - use uart2 instead of uart1
> >> - DVI-D connector instead of VGA
> >> - no audio
> >> - no SATA connector
> >> - CCAT FPGA connected to emi
> >> - enable rtc
> >>
> >> Signed-off-by: Patrick Bruenn <p.bruenn@beckhoff.com>
> >
> >Where is the patch 1/2?
> >
> You can find a copy here [1], or wait for the next revision, I will try to improve my git send-mail skills until then.
> I used git send-email with "--to-cmd ./scripts/get_maintainer.pl" to send the series. I just
> discovered it would have been better to use To: and Cc: in the cover letter and send with
> "--to-cover --cc-cover".
> I will drop "--in-reply-to" for the next revision, too...
> Is there something like patman [2] from the u-boot project for the kernel, that I am missing?

I do not use anything like that, but always manually edit recipients.
It's a bit silly, but can make the recipients more precise and limited.

> >>
> >> ---
> >>
> >> v4:
> >> - move alternative UART2 pinmux settings to imx53-pinfunc.h
> >> - fix copyright notice and model name to clearify cx9020 is a
> >>   Beckhoff board and not from Freescale/NXP/Qualcomm
> >> - add "bhf,cx9020" compatible
> >> - remove ccat node and pin configuration as long as the ccat
> >>   driver is not mainlined
> >> - use dvi-connector + ti,tfp410 instead of panel-simple
> >> - add newlines between property list and child nodes
> >> - replace underscores in node names with hypens
> >> - replace magic number 0 with polarity defines from
> >>   include/dt-bindings/gpio/gpio.h
> >> - move rtc node into imx53.dtsi, change it's name into 'srtc',
> >>   to avoid a conflict with 'rtc' node in imx53-m53.dtsi
> >> - rename regulator-3p2v
> >> - drop imx53-qsb container node
> >> - make iomux configuration explicit
> >> - remove unused audmux
> >> - remove unused led_pin_gpio3_23 configuration
> >> - use blue gpio-leds as disk-activity indicators for mmc0 and mmc1
> >> - add mmc indicator leds to sdhc pingroups
> >> - keep node names in alphabetical order
> >> - remove unused sata and ssi2
> >> - remove unused pin configs from hoggrp
> >> - add entry for imx53-cx9020.dts to MAINTAINERS
> >>
> >> v3: add missig changelog
> >> v2:
> >> - keep alphabetic order of dts/Makefile
> >> - configure uart2 with 'fsl,dte-mode'
> >> - use display-0 and panel-0 as node names
> >> - remove unnecessary "simple-bus" for fixed regulators
> >>
> >> Cc: Andrew Lunn <andrew@lunn.ch>
> >> ---
> >>  MAINTAINERS                        |   1 +
> >
> >I do not take the changes on this file.
> >
> Do you mean you keep maintainership for imx53-cx9020.dts, or do you
> mean I should group it in the patch which adds imx53-cx9020.dts?
> I am fine with both and would be glad to have your guidance. I just
> didn't understand clearly what was meant.

I meant that I do not have the authority to take patches that update
MAINTAINERS file.  But now I think we do not even need to update
MAINTAINERS just for imx53-cx9020.dts, since we already have IMX
maintainer-ship covering all IMX dts files.

ARM/FREESCALE IMX / MXC ARM ARCHITECTURE
...
F:      arch/arm/boot/dts/imx*

Shawn
