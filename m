From: zhang.lei@jp.fujitsu.com (Zhang, Lei)
Date: Thu, 21 Jun 2018 10:57:28 +0000
Subject: [PATCH v3] irqchip/gic-v3: Ensure GICR_CTLR.EnableLPI=0 is
 observed before enabling
In-Reply-To: <86tvpy7s1g.wl-marc.zyngier@arm.com>
References: <1521683929-15644-1-git-send-email-shankerd@codeaurora.org>
 <d1161c2d-e16d-14e6-5450-be26d348100d@arm.com>
 <8087e009-4eca-ab92-cbca-23ccfb3fafac@codeaurora.org>
 <86o9jf174o.wl-marc.zyngier@arm.com>
 <8898674D84E3B24BA3A2D289B872026A69F37935@G01JPEXMBKW03>
 <86tvpy7s1g.wl-marc.zyngier@arm.com>
Message-ID: <8898674D84E3B24BA3A2D289B872026A69F3B4A4@G01JPEXMBKW03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc

> - If EnableLPI is already set to 1, your redistributors are already
>   potentially corrupting the memory by writing to the pending
>   tables. Your system is now potentially unstable (single bit
>   corruption, depending on what the ITS outputs).
> 
> - If EnableLPI has become RES1, you cannot even turn it off to
>   reprogram things so that the property and pending tables are under
>   your control.
Thanks for you reply.

One more question.
If EnableLPIs bit becomes RES1 after EnableLPIs has been written to 1,
DKUMP/KEXEC case will enter kernel with GICR_CTLR.EnableLPIs=1.
In this case I do not think DKUMP/KEXEC can work well even use irqchip.gicv3_nolpi, 
if secondary kernel need to use LPI such as the disk is nvme. Am I right?

I have seen the discussion as below URL, but I do not really understand the conclusion.
https://patchwork.kernel.org/patch/10281325/
