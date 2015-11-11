From: will.deacon@arm.com (Will Deacon)
Date: Wed, 11 Nov 2015 17:44:01 +0000
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <20151111.123548.1039494689070388545.davem@davemloft.net>
References: <56436420.9090401@iogearbox.net> <20151111162341.GN9562@arm.com>
 <20151111172659.GA86334@ast-mbp.thefacebook.com>
 <20151111.123548.1039494689070388545.davem@davemloft.net>
Message-ID: <20151111174401.GO9562@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 11, 2015 at 12:35:48PM -0500, David Miller wrote:
> From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Date: Wed, 11 Nov 2015 09:27:00 -0800
> 
> > BPF_XADD == atomic_add() in kernel. period.
> > we are not going to deprecate it or introduce something else.
> 
> Agreed, it makes no sense to try and tie C99 or whatever atomic
> semantics to something that is already clearly defined to have
> exactly kernel atomic_add() semantics.

... and which is emitted by LLVM when asked to compile __sync_fetch_and_add,
which has clearly defined (yet conflicting) semantics.

If the discrepancy is in LLVM (and it sounds like it is), then I'll raise
a bug over there instead.

Will
