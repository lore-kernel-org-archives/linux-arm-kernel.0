From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 13:32:16 +0200
Subject: [PATCH v2 0/8] initial suport for Alpscale ASM9260
In-Reply-To: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
Message-ID: <2866817.DgJ1GRrWVo@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 21 September 2014 20:41:36 Oleksij Rempel wrote:
> This patchset provide initial support for Alpscale ASM9260,
> ARM based SoC.
> 
> Oleksij Rempel (8):
>   ARM: add mach-asm9260
>   add include/debug/asm9260.S
>   add alphascale,asm9260.h binding
>   ARM: dts: add DT for Alphascale ASM9260 SoC
>   clk: add clk-asm9260 driver
>   clocksource: add asm9260_timer driver
>   irqchip: add irq-asm9260 driver
>   tty/serial: add asm9260-serial driver
> 

One more general comment: given the similarities between ASM9260
and the Sigmatel/Freescale chips, I wonder if it makes sense to
move the platform code into arch/arm/mach-mxs. I don't know the
exact relationship between the designs, so it's possible that they
are not actually that closely related, you'd have to find out
for yourselves.

In any case, I think any new driver should probably use the
reset interface and macros from include/linux/stmp_device.h

	Arnd
