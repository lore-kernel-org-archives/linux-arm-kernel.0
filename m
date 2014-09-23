From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 14:56:37 +0200
Subject: [PATCH v8 09/10] rtc: at91sam9: add DT bindings documentation
In-Reply-To: <1411471444-2764-10-git-send-email-boris.brezillon@free-electrons.com>
References: <1411471444-2764-1-git-send-email-boris.brezillon@free-electrons.com>
 <1411471444-2764-10-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <3728270.N2tTcyeJmL@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 13:24:03 Boris BREZILLON wrote:
> Add RTT bindings documentation.

Two minor comments here:

> +Atmel AT91SAM9260 Real Time Timer
> +
> +Required properties:
> +- compatible: should be: "atmel,at91sam9260-rtt"
> +- reg: should encode the memory region of the RTT controller
> +- interrupts: rtt alarm/event interrupt
> +- clocks: should contain one clock pointing to the slow clk

This should document what the clock is used for, not where it's
connected.

> +
> +rtt at fffffe00 {
> +       compatible = "atmel,at91sam9260-rtt";
> +       reg = <0xfffffd20 0x10>;
> +       interrupts = <1 4 7>;
> +       clocks = <&clk32k>;
> +       atmel,rtt-rtc-time-reg = <&gpbr 0x0>;
> +};
> 

The register address fffffd20 does not match the name fffffe00

	Arnd
