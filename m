From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Tue, 24 Jul 2018 15:57:06 +0200
Subject: [PATCH RT v2] arm64: fpsimd: use a local_lock() in addition to
 local_bh_disable()
In-Reply-To: <20180724094623.37430032@gandalf.local.home>
References: <20180522172115.fpqguqlsq6bavtxy@linutronix.de>
 <20180522132429.6f1dcf92@gandalf.local.home>
 <20180522173333.aawadhkcekzvrswp@linutronix.de>
 <20180711092555.268adf7f@gandalf.local.home>
 <20180711133157.bvrza5vmthu6lwjd@linutronix.de>
 <20180711093346.782af07a@gandalf.local.home>
 <20180713174937.5ddaqpylalcmc3jq@linutronix.de>
 <20180716151737.GO9486@e103592.cambridge.arm.com>
 <20180718091209.u76gzacanj5avhdl@linutronix.de>
 <20180724094623.37430032@gandalf.local.home>
Message-ID: <20180724135706.nn2exgz53o7jfwm4@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018-07-24 09:46:23 [-0400], Steven Rostedt wrote:
> > Unfortunately yes.
> 
> Then we need to find another solution, because this is way too ugly and
> as Dave said, fragile to keep.

Yes. I have something new where Mike said it works (while this causes
Mike's gcc to segfault). Need to test this myself?

> How does local_lock_bh() do a +3 (not seeing it in the code). And

get_local_var() +1
spin_lock_bh() +2 because
	local_bh_disable() +1
	spin_lock() +1

Sebastian
