From: eric@anholt.net (Eric Anholt)
Date: Mon, 30 Jan 2017 15:30:13 -0800
Subject: [PATCH v2] ARM: bcm2835: dts: fix uart0 pinctrl node names
In-Reply-To: <f37d02c769d0e2b6db2529cafb86b5fdd1e09a94.1485715259.git.baruch@tkos.co.il>
References: <f37d02c769d0e2b6db2529cafb86b5fdd1e09a94.1485715259.git.baruch@tkos.co.il>
Message-ID: <87vaswunwa.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Baruch Siach <baruch@tkos.co.il> writes:

> Downstream kernel uses pins 32, 33 as UART0 (PL011) Rx/Tx to communicate with
> the Bluetooth chip. So ALT3 of these pins is most likely not CTS/RTS. Change
> the node name to reflect that. This matches section 6.2 "Alternative Function
> Assignments" in the BCM2835 ARM Peripherals document.
>
> With this change in place, adding
>
>   &uart0 {
> 	 pinctrl-names = "default";
> 	 pinctrl-0 = <&uart0_gpio32 &gpclk2_gpio43>;
> 	 status = "okay";
>   };
>
> to bcm2837-rpi-3-b.dts does the right thing on my Raspberry Pi 3.
>
> Pins 30, 31 are CTS/RTS of UART0 in alternate function 3. Rename uart0_gpio30
> as well.
>
> While at it, fix a little typo in a nearby comment.
>
> Fixes: 21ff843931b ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")
> Acked-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

Reviewed-by: Eric Anholt <eric@anholt.net>

Working on putting together a new dt-next branch now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170130/87ad1bff/attachment.sig>
