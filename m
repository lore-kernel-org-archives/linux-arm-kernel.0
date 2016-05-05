From: horms@verge.net.au (Simon Horman)
Date: Fri, 6 May 2016 08:49:07 +0900
Subject: [PATCH 0/3] ARM/arm64: dts: renesas: Describe RTS/CTS hardware
 flow control
In-Reply-To: <1462352278-30327-1-git-send-email-geert+renesas@glider.be>
References: <1462352278-30327-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20160505234906.GD24999@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Wed, May 04, 2016 at 10:57:55AM +0200, Geert Uytterhoeven wrote:
> 	Hi Simon, Magnus,
> 
> This patch series updates the various Renesas DTSes to describe that
> some UARTS have dedicated lines for RTS/CTS hardware flow control, and
> that they are available for use (wired and enabled by pinmux
> configuration), by adding the "uart-has-rtscts" property to
> board-specific DTS files where appropriate.
> 
> While the actual DT binding updates documenting the "uart-has-rtscts"
> property for SCIF(A) UARTs ("serial: sh-sci: Update DT binding
> documentation for dedicated RTS/CTS") hasn't been accepted into tty-next
> yet, this property is part of the Generic Serial DT Bindings
> (Documentation/devicetree/bindings/serial/serial.txt), which has been
> accepted.

On the basis of the binding being present in the generic documentation
I have queued up these patches. If that was not your intention please
let me know.

> Actual enablement of RTS/CTS hardware flow control (through setting the
> CRTSCTS termios flag from userspace) depends on series "[PATCH v2 00/11]
> serial: sh-sci: Hardware Flow Control Updates"
> (http://www.spinics.net/lists/linux-serial/msg22535.html).
> Note that setting the CRTSCTS flag for a serial port that is being used
> as the kernel console is a bad idea ;-) You'll have better luck with
> UARTs on expansion connectors, cfr. the topic/renesas-overlays branch of
> https://git.kernel.org/cgit/linux/kernel/git/geert/renesas-drivers.git
> 
> Thanks!
> 
> Geert Uytterhoeven (3):
>   ARM: dts: bockw: SCIF0 supports RTS/CTS hardware flow control
>   ARM: dts: kzm9g: SCIFA4 supports RTS/CTS hardware flow control
>   arm64: dts: salvator-x: SCIF1 supports RTS/CTS hardware flow control
> 
>  arch/arm/boot/dts/r8a7778-bockw.dts                | 1 +
>  arch/arm/boot/dts/sh73a0-kzm9g.dts                 | 1 +
>  arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts | 1 +
>  3 files changed, 3 insertions(+)
> 
> -- 
> 1.9.1
> 
> Gr{oetje,eeting}s,
> 
> 						Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
> 							    -- Linus Torvalds
> 
