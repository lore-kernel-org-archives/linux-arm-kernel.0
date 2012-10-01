From: cavokz@gmail.com (Domenico Andreoli)
Date: Mon, 1 Oct 2012 22:30:21 +0200
Subject: [PATCH V5 3/5] ARM: bcm2835: add system timer
In-Reply-To: <1347690093-16910-3-git-send-email-swarren@wwwdotorg.org>
References: <1347690093-16910-1-git-send-email-swarren@wwwdotorg.org>
 <1347690093-16910-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20121001203020.GA9346@raptus.dandreoli.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 15, 2012 at 12:21:31AM -0600, Stephen Warren wrote:
> 
> diff --git a/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> new file mode 100644
> index 0000000..a0b727f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm2835-system-timer.txt
> @@ -0,0 +1,22 @@
> +BCM2835 System Timer
> +
> +The System Timer peripheral provides four 32-bit timer channels and a
> +single 64-bit free running counter. Each channel has an output compare
> +register, which is compared against the 32 least significant bits of the
> +free running counter values, and generates an interrupt.
> +
> +Required properties:
> +
> +- compatible : should be "brcm,bcm2835-system-timer.txt"
                                                      ^^^^
typo here

> +- reg : Specifies base physical address and size of the registers.
> +- interrupts : A list of 4 interrupt sinks; one per timer channel.
> +- clock-frequency : The frequency of the clock that drives the counter, in Hz.
> +
> +Example:
> +
> +timer {
> +	compatible = "brcm,bcm2835-system-timer";
> +	reg = <0x20003000 0x1000>;
> +	interrupts = <1 0>, <1 1>, <1 2>, <1 3>;
> +	clock-frequency = <1000000>;
> +};

cheers,
Domenico
