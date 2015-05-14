From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 14 May 2015 17:40:41 +0200
Subject: [PATCHv2 2/3] arm64: Allow forced irq threading
In-Reply-To: <1430167990-12333-3-git-send-email-anders.roxell@linaro.org>
References: <1430167990-12333-1-git-send-email-anders.roxell@linaro.org>
 <1430167990-12333-3-git-send-email-anders.roxell@linaro.org>
Message-ID: <20150514154041.GC13442@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Anders Roxell | 2015-04-27 22:53:09 [+0200]:

>Now its safe to allow forced interrupt threading for arm64,
>all timer interrupts and the perf interrupt are marked NO_THREAD, as is
>the case with arch/arm: da0ec6f ARM: 7814/2: Allow forced irq threading
>
>Suggested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Please, could this go via the ARM64 tree?

>---
> arch/arm64/Kconfig | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>index 9532f8d..3708eec 100644
>--- a/arch/arm64/Kconfig
>+++ b/arch/arm64/Kconfig
>@@ -61,6 +61,7 @@ config ARM64
> 	select HAVE_RCU_TABLE_FREE
> 	select HAVE_SYSCALL_TRACEPOINTS
> 	select IRQ_DOMAIN
>+	select IRQ_FORCED_THREADING
> 	select MODULES_USE_ELF_RELA
> 	select NO_BOOTMEM
> 	select OF


Sebastian
