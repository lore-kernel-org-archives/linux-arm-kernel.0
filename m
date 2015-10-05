From: davem@davemloft.net (David Miller)
Date: Mon, 05 Oct 2015 07:03:14 -0700 (PDT)
Subject: [PATCH net-next V2] ARM: net: support BPF_ALU | BPF_MOD
 instructions in the BPF JIT.
In-Reply-To: <1443798407-19154-1-git-send-email-nschichan@freebox.fr>
References: <1443798407-19154-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20151005.070314.997252169637059167.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Fri,  2 Oct 2015 17:06:47 +0200

> For ARMv7 with UDIV instruction support, generate an UDIV instruction
> followed by an MLS instruction.
> 
> For other ARM variants, generate code calling a C wrapper similar to
> the jit_udiv() function used for BPF_ALU | BPF_DIV instructions.
> 
> Some performance numbers reported by the test_bpf module (the duration
> per filter run is reported in nanoseconds, between "jitted:<x>" and
> "PASS":
> 
> ARMv7 QEMU nojit:	test_bpf: #3 DIV_MOD_KX jited:0 2196 PASS
> ARMv7 QEMU jit:		test_bpf: #3 DIV_MOD_KX jited:1 104 PASS
> ARMv5 QEMU nojit:	test_bpf: #3 DIV_MOD_KX jited:0 2176 PASS
> ARMv5 QEMU jit:		test_bpf: #3 DIV_MOD_KX jited:1 1104 PASS
> ARMv5 kirkwood nojit:	test_bpf: #3 DIV_MOD_KX jited:0 1103 PASS
> ARMv5 kirkwood jit:	test_bpf: #3 DIV_MOD_KX jited:1 311 PASS
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>

Applied, thanks.
