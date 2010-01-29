From: dwalker@codeaurora.org (Daniel Walker)
Date: Fri, 29 Jan 2010 09:59:29 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
Message-ID: <1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-01-29 at 09:55 -0800, Ruan, Willie wrote:
> > From: Catalin Marinas [mailto:catalin.marinas at arm.com] 
> > Sent: Friday, January 29, 2010 3:09 AM
> >
> > Do we need any for of locking around this code (as we do for
> > l2x0_inv_all) or races are not possible during suspend?
> 
> Local interrupts have been disabled in suspend_ops->enter and
> in arch_idle. Thus, no other locking is necessary.

What if there are multiple cpu's calling cache_sync() at the same time?
Disable interrupt wouldn't prevent it ..

Daniel
