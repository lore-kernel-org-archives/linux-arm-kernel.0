From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 22:52:13 +0200
Subject: [Urgent PATCH] arm64: dts: uniphier: fix IRQ trigger type of
 ARMv8 timer
In-Reply-To: <1470039140-3801-1-git-send-email-yamada.masahiro@socionext.com>
References: <1470039140-3801-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1769666.3m3onKVFl3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, August 1, 2016 5:12:20 PM CEST Masahiro Yamada wrote:
> Since commit 1e2a7d78499e ("irqdomain: Don't set type when mapping
> an IRQ"), the interrupt type is strictly checked.  Without this
> patch, this board would not boot any more.
> 
> Documentation/devicetree/bindings/interrupt-controller/arm,gic-v3.txt
> says that the 3rd cell should be either 1 (edge) or 4 (level)
> depending on the trigger type.  As the CA72 Generic Timer provides
> active-low interrupts, the value of the 3rd cell should be 4.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> 

I've added it to the fixes branch now, sorry for the delay.

	Arnd
