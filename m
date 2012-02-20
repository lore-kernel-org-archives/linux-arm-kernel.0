From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Mon, 20 Feb 2012 12:03:49 +0100
Subject: [PATCH RFC 0/4] Scheduler idle notifiers and users
In-Reply-To: <20120217090022.GA24856@comet.dominikbrodowski.net>
References: <1328670355.2482.68.camel@laptop>
 <20120208202314.GA28290@redhat.com> <1328736834.2903.33.camel@pasglop>
 <20120209075106.GB18387@elte.hu> <4F35DD3E.4020406@codeaurora.org>
 <20120211144530.GA497@elte.hu> <4F3AEC4E.9000303@codeaurora.org>
 <1329313085.2293.106.camel@twins>
 <20120215140245.GB27825@n2100.arm.linux.org.uk>
 <1329318063.2293.136.camel@twins>
 <20120217090022.GA24856@comet.dominikbrodowski.net>
Message-ID: <1329735829.2293.309.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-02-17 at 10:00 +0100, Dominik Brodowski wrote:
> 
> Well, we can actually have both: Adding a new cpufreq governor "scheduler"
> is easy. The scheduler stores the target frequency (in per-cent or
> per-mille) in (per-cpu) data available to this governor, and kick a
> (per-cpu?) thread which then handels the rest -- by existing cpufreq means.
> The cpufreq part is easy, the sched part less so (I think). 

You might not have been reading what I wrote, kicking a kthread (or
doing any other scheduler activity) from within the scheduler is way
ugly and something I'd really rather avoid if at all possible.

Yes I could do it, but I really really don't want to.
