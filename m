From: peterz@infradead.org (Peter Zijlstra)
Date: Fri, 17 Jun 2016 18:14:13 +0200
Subject: [PATCH] arm64: barrier: implement wfe-base smp_cond_load_acquire
In-Reply-To: <20160617160415.GC1284@arm.com>
References: <1466169136-28672-1-git-send-email-will.deacon@arm.com>
 <20160617142738.GA20181@leverpostej>
 <20160617153803.GA1284@arm.com>
 <20160617154242.GZ30154@twins.programming.kicks-ass.net>
 <20160617160415.GC1284@arm.com>
Message-ID: <20160617161413.GB30154@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 05:04:15PM +0100, Will Deacon wrote:
> To be honest, it's never been clear to me what purpose the memory clobber
> serves in cpu_relax().

Oh, that stems from before ACCESS_ONCE(), and was all that made these
wait loops work at all.
