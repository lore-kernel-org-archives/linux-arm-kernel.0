From: davem@davemloft.net (David Miller)
Date: Wed, 11 Nov 2015 14:01:47 -0500 (EST)
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111181132.GA90947@ast-mbp.thefacebook.com>
References: <20151111.123548.1039494689070388545.davem@davemloft.net>
 <20151111175741.GR17308@twins.programming.kicks-ass.net>
 <20151111181132.GA90947@ast-mbp.thefacebook.com>
Message-ID: <20151111.140147.946865774411167562.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Nov 2015 10:11:33 -0800

> bpf_xadd was never meant to be __sync_fetch_and_add equivalent.
> From the day one it meant to be atomic_add() as kernel does it.

+1

> I did piggy back on __sync in the llvm backend because it was the quick
> and dirty way to move forward.
> In retrospect I should have introduced a clean intrinstic for that instead,
> but it's not too late to do it now. user space we can change at any time
> unlike kernel.

+1
