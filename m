From: wruan@quicinc.com (Ruan, Willie)
Date: Fri, 29 Jan 2010 10:23:55 -0800
Subject: [RFC PATCH 04/12] arm: mm: cache-l2x0: add l2x0 suspend and
	resume functions
In-Reply-To: <1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
References: <1264719577-5436-5-git-send-email-dwalker@codeaurora.org>
	<1264763312.4242.47.camel@pc1117.cambridge.arm.com>
	<179C5F34D68DF54C8898E904FC5BAF8C79E15B77C4@NALASEXMB09.na.qualcomm.com>
	<1264787969.1818.6.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <179C5F34D68DF54C8898E904FC5BAF8C79E15B77CD@NALASEXMB09.na.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Daniel Walker [mailto:dwalker at codeaurora.org] 
> Sent: Friday, January 29, 2010 9:59 AM
>
> What if there are multiple cpu's calling cache_sync() at the same time?
> Disable interrupt wouldn't prevent it ..

cache_sync() is calling sync_writel(), which is using spin_lock_irqsave().
So, each call of cache_sync() and sync_writel() is SMP safe individually
in l2x0_flush_all() as in l2x0_inv_all(), unless we need to protect the
two calls together, which seems not necessary to me.

Thanks,
~Willie
