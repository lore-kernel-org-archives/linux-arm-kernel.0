From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 May 2015 16:50:32 +0200
Subject: [PATCH soc] ARM: use ARM_SINGLE_ARMV7M for ARMv7-M platforms
In-Reply-To: <1432161344-1930-1-git-send-email-stefan@agner.ch>
References: <1432161344-1930-1-git-send-email-stefan@agner.ch>
Message-ID: <15864413.ed8EFg1NLl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 21 May 2015 00:35:44 Stefan Agner wrote:
> Use the new config symbol ARM_SINGLE_ARMV7M which groups config
> symbols used by modern ARMv7-M platforms. This allows supporting
> multiple ARMv7-M platforms in one kernel image. However, a common
> kernel image requires the combined platforms to share the same
> main memory layout to be bootable.
> 
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
> Since this is essentially only a shift of config symbols, it
> should not change runtime behavior, at least when selecting
> only one platform.
> 
> Uwe, this is essentially the same I had in my patchset, just
> converting the other platforms too. I was bold and added your
> Ack anyway...
> 
> Joachim, Maxime, I test compiled with your defconfigs, compiled
> fine on my machine.

I've applied the patch now with all three Acks added (and reordered
with regard to the Signed-off-by).

Thanks!

[one small request as I have four armv7-m folks on Cc already:
 could one of you try to fix the warning that I get with every
 single build: "/git/arm-soc/arch/arm/kernel/head-nommu.S: Assembler
messages: /git/arm-soc/arch/arm/kernel/head-nommu.S:167: Warning:
Use of r13 as a source register is deprecated when r15 is the
destination register."]

	Arnd
