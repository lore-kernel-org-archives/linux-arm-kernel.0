From: peterz@infradead.org (Peter Zijlstra)
Date: Wed, 11 Nov 2015 23:21:35 +0100
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111195558.GA4173@ast-mbp.thefacebook.com>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
 <20151111181132.GA90947@ast-mbp.thefacebook.com>
 <20151111183128.GS17308@twins.programming.kicks-ass.net>
 <20151111184427.GH11639@twins.programming.kicks-ass.net>
 <20151111185415.GI11639@twins.programming.kicks-ass.net>
 <20151111195558.GA4173@ast-mbp.thefacebook.com>
Message-ID: <20151111222135.GU17308@twins.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 11:55:59AM -0800, Alexei Starovoitov wrote:
> Therefore things like memory barriers, full set of atomics are not applicable
> in bpf world.

There are still plenty of wait-free constructs one can make using them.

Say a barrier/rendezvous construct for knowing when an event has
happened on all CPUs.

But if you really do not want any of that, I suppose that is a valid
choice.


Is even privileged (e)BPF not allowed things like this? I was thinking
the strict no loops stuff was for unpriv (e)BPF only.
