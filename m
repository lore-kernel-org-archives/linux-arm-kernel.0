From: wruan@quicinc.com (Ruan, Willie)
Date: Fri, 29 Jan 2010 09:55:30 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264763312.4242.47.camel@pc1117.cambridge.arm.com>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
Message-ID: <179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
> Sent: Friday, January 29, 2010 3:09 AM
>
> Do we need any for of locking around this code (as we do for
> l2x0_inv_all) or races are not possible during suspend?

Local interrupts have been disabled in suspend_ops->enter and
in arch_idle. Thus, no other locking is necessary.

~Willie
