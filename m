From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 13:21:17 +0100
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding
 documentation for bcm2835-aux-uart
In-Reply-To: <175E89CE-581C-48AB-B7FF-6E9A41B033D5@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <10159898.8xe3rmYdEi@wuerfel>
 <175E89CE-581C-48AB-B7FF-6E9A41B033D5@martin.sperl.org>
Message-ID: <4288762.bCLxQBDvy4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 10 January 2016 11:49:19 Martin Sperl wrote:
> The existing dts arch/arm/boot/dts/bcm2835.dtsi already contains:
>                 uart0: uart at 7e201000 {
>                         compatible = "brcm,bcm2835-pl011", "arm,pl011", "arm,primecell";
>                         reg = <0x7e201000 0x1000>;
>                         interrupts = <2 25>;
>                         clocks = <&clocks BCM2835_CLOCK_UART>,
>                                  <&clocks BCM2835_CLOCK_VPU>;
>                         clock-names = "uartclk", "apb_pclk";
>                         arm,primecell-periphid = <0x00241011>;
>                 };
> for the primary uart.
> 
> So I was just following that example and would hesitate to
> use a different nomenclature in the same file (even though I
> saw serial examples elsewhere).
> 
> I guess this is a more general thing that needs to get resolved.
> 
> If you tell me to re-spin the patch because of this then I can do that,
> but that would not solve the issue with uart0.

Please just add another patch to rename the existing uarts appropriately
first, then add this one on top with the correct name.

	Arnd
