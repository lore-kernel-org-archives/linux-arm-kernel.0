From: davem@davemloft.net (David Miller)
Date: Mon, 16 Nov 2015 14:42:16 -0500 (EST)
Subject: [PATCH] bpf, arm64: start flushing icache range from header
In-Reply-To: <41c4a481eb665a492c3b2df16af219b1250224a0.1447446460.git.daniel@iogearbox.net>
References: <41c4a481eb665a492c3b2df16af219b1250224a0.1447446460.git.daniel@iogearbox.net>
Message-ID: <20151116.144216.8808948219258398.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Sat, 14 Nov 2015 01:16:18 +0100

> While recently going over ARM64's BPF code, I noticed that the icache
> range we're flushing should start at header already and not at ctx.image.
> 
> Reason is that after b569c1c622c5 ("net: bpf: arm64: address randomize
> and write protect JIT code"), we also want to make sure to flush the
> random-sized trap in front of the start of the actual program (analogous
> to x86). No operational differences from user side.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> ---
>  ( As arm64 jit fixes seem to go via arm64 tree, sending them here. )

I'm applying this directly, please CC: netdev on future patches
to the BPF JIT's regardless of where you think the patch will
be applied as it should be _REVIEWED_ on netdev regardless.
