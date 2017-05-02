From: davem@davemloft.net (David Miller)
Date: Tue, 02 May 2017 15:06:04 -0400 (EDT)
Subject: [PATCH net] bpf, arm64: fix jit branch offset related to ldimm64
In-Reply-To: <5f7d105a1830ed789f1b416dc17b02fce0bd070e.1493749880.git.daniel@iogearbox.net>
References: <5f7d105a1830ed789f1b416dc17b02fce0bd070e.1493749880.git.daniel@iogearbox.net>
Message-ID: <20170502.150604.1278120708759571672.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue,  2 May 2017 20:34:54 +0200

> When the instruction right before the branch destination is
> a 64 bit load immediate, we currently calculate the wrong
> jump offset in the ctx->offset[] array as we only account
> one instruction slot for the 64 bit load immediate although
> it uses two BPF instructions. Fix it up by setting the offset
> into the right slot after we incremented the index.
 ...
> Also, add a couple of test cases to make sure JITs pass
> this test. Tested on Cavium ThunderX ARMv8. The added
> test cases all pass after the fix.
> 
> Fixes: 8eee539ddea0 ("arm64: bpf: fix out-of-bounds read in bpf2a64_offset()")
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Alexei Starovoitov <ast@kernel.org>

Applied and queued up for -stable, thanks!

I also applied your XADD patch as well.

Thanks again.
