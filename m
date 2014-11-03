From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 03 Nov 2014 18:38:10 +0100
Subject: [PATCH 04/17] irqchip: irq-armada-370-xp: suspend/resume support
In-Reply-To: <1414151970-6626-5-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1414151970-6626-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1414151970-6626-5-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <5457BD82.3090309@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On 24/10/2014 13:59, Thomas Petazzoni wrote:
> This commit adds suspend/resume support to the irqchip driver used on
> Armada XP platforms (amongst others). It does so by adding a set of
> suspend/resume syscore_ops, that will respectively save and restore
> the necessary registers to ensure interrupts continue to work after
> resume.
> 
> It is worth mentioning that the affinity is lost during a
> suspend/resume cycle, because when a secondary CPU is brought
> off-line, all interrupts that are assigned to this CPU in terms of
> affinity gets re-assigned to a still running CPU. Therefore, right
> before entering suspend, all interrupts are assigned to the boot CPU.

So what about /proc/irq/*/smp_affinity ?

Do this files still represent accurate information?

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
