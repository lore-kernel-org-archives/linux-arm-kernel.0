From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Nov 2015 09:56:01 +0100
Subject: [PATCH] ARM: at91/dt: sama5d4: Add pinmux for 8-bit MMC0 bus
In-Reply-To: <1446420376-5419-1-git-send-email-marex@denx.de>
References: <1446420376-5419-1-git-send-email-marex@denx.de>
Message-ID: <5639C821.9040405@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Le 02/11/2015 00:26, Marek Vasut a ?crit :
> Add pinmux for the 4 remaining signals used in 8-bit MMC 0 bus
> configuration.
> 
> Signed-off-by: Marek Vasut <marex@denx.de> Cc: Alexandre Belloni
> <alexandre.belloni@free-electrons.com> Cc: Josh Wu
> <josh.wu@atmel.com> Cc: Nicolas Ferre <nicolas.ferre@atmel.com> 
> --- arch/arm/boot/dts/sama5d4.dtsi | 8 ++++++++ 1 file changed, 8
> insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d4.dtsi
> b/arch/arm/boot/dts/sama5d4.dtsi index 8d1de29..f9f6108 100644 ---
> a/arch/arm/boot/dts/sama5d4.dtsi +++
> b/arch/arm/boot/dts/sama5d4.dtsi @@ -1651,6 +1651,14 @@ AT91_PIOC 9
> AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with
> NAND_D4 */

Oh, I see an error over there: it's actually MCI0_DA3 in the comment!
Idea for another patch ;-)


> >; }; +					pinctrl_mmc0_dat4_7: mmc0_dat4_7 { +						atmel,pins = 
> +							<AT91_PIOC 10 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/*
> MCI0_DB1, conflict with NAND_D5 */

Ok, so here also, the error comes from the comment: it's MCI0_DA4 up
to MCI0_DA7.

The "A" stands for "slot 0" that you would instantiate in your board's
.dts

> +							 AT91_PIOC 11 AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/*
> MCI0_DB2, conflict with NAND_D6 */ +							 AT91_PIOC 12
> AT91_PERIPH_B AT91_PINCTRL_PULL_UP	/* MCI0_DB3, conflict with
> NAND_D7 */ +							 AT91_PIOC 13 AT91_PERIPH_B AT91_PINCTRL_PULL_UP
> /* MCI0_DB3, conflict with NAND_D8 */ +							>; +					}; };
> 
> mmc1 {

So Marek, you can send a v2 of this patch or I can do these changes if
you prefer, tell me.

Bye,
- -- 
Nicolas Ferre
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOcghAAoJEAf03oE53VmQ3z4H/RTx1W2kbDZ3cDSX22Tpn2ew
BKGJYk4dvNGNO9NTxLDUxTVqfnp7hBzxCshEZ9QO3er6baAXDrCzGfaqBex9Dy9U
lFpQxTgBMoudJdOci4KLqSghlZ2XVpv0uumtYEQL03rJ9jDyFhnvJhlaLbyVhqIC
QG1MiObmLxAFQKQKnCJzA+AttxIPvtKmmrCUHumlOAvY0V0Do8kbNgq0dEc9/tRC
7jui2+v0ALm7+qDpsvKBa/VzTLZKKVjCMrWaAVWyBTp8XCmKWuljDSlhep66v3G6
EBV6d5SdcjOWnIFbaS5Px/HpT2yBV+RyegZk5Vejf0Jnxc7KK6YsJNxCsFbZ4TU=
=th+u
-----END PGP SIGNATURE-----
