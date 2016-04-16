From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 16 Apr 2016 18:30:35 +0200
Subject: [PATCH 1/5] doc: DT: Add Generic Serial Device Tree Bindings
In-Reply-To: <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
References: <1460636003-3011-1-git-send-email-geert+renesas@glider.be>
 <1460636003-3011-2-git-send-email-geert+renesas@glider.be>
Message-ID: <5792073.qsBJ1LK659@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 14 April 2016 14:13:19 Geert Uytterhoeven wrote:
> Document a set of generic properties for describing UARTs in a
> device tree:
>   1. The GPIO modem control properties are currently duplicated across
>      hardware-specific binding documentation,
>   2. The property for dedicated RTS/CTS hardware flow control lines is
>      already supported by several drivers, albeit with a vendor-specific
>      prefix, hence make it generic.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Originally the ISA 8250 uart binding (from ieee) was used as the
template for other uart bindings. How about documenting the parts that
are used in 8250-of today (current-speed, clock-frequency,
reg-offset, reg-shift, fifo-size, reg-io-width, auto-flow-control)
in the same file?

>  - out1-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>    used as the UART's OUT1 line.
>  - out2-gpios: Must contain a GPIO specifier, referring to the GPIO pin to be
>    used as the UART's OUT2 line.

I had to look up what OUT1 and OUT2 are, but I still don't see how you'd
implement them using a GPIO line: From all I can tell, these are usually
internal registers in a hardware uart but they are not assigned to an
external line on the standard db9 or even the old db25 connectors. Should
we drop these instead?

On a related note, do you think it would be possible to do a bit-banged
uart if we defined gpio lines for rxd and txd?

	Arnd
