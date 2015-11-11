From: davem@davemloft.net (David Miller)
Date: Wed, 11 Nov 2015 14:04:53 -0500 (EST)
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <56438DE7.4080300@iogearbox.net>
References: <20151111181132.GA90947@ast-mbp.thefacebook.com>
 <20151111183128.GS17308@twins.programming.kicks-ass.net>
 <56438DE7.4080300@iogearbox.net>
Message-ID: <20151111.140453.442347400380318914.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Wed, 11 Nov 2015 19:50:15 +0100

> Well, on that note, it's not like you just change the target to bpf
> in your Makefile and can compile (& load into the kernel) anything
> you want with it.  You do have to write small, restricted programs
> from scratch for a specific use-case with the limited set of helper
> functions and intrinsics that are available from the kernel. So I
> don't think that "Programs that used to work will now no longer
> work." holds if you regard it as such.

+1

Strict C language semantics do not apply here at all, we are talking
about purposfully built modules of "C like" code that have any
semantics we want and make the most sense for us.

Maybe BPF_XADD is unfortunately named, but this is tangental to
our ability to choose what atomic operations mean and what semantics
they match up to.
