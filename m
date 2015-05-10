From: davem@davemloft.net (David Miller)
Date: Sun, 10 May 2015 19:20:55 -0400 (EDT)
Subject: [PATCH v2] ARM: net fix emit_udiv() for BPF_ALU | BPF_DIV |
 BPF_K intruction.
In-Reply-To: <1430929916-15852-1-git-send-email-nschichan@freebox.fr>
References: <1430929916-15852-1-git-send-email-nschichan@freebox.fr>
Message-ID: <20150510.192055.1922692719262473644.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Schichan <nschichan@freebox.fr>
Date: Wed,  6 May 2015 18:31:56 +0200

> In that case, emit_udiv() will be called with rn == ARM_R0 (r_scratch)
> and loading rm first into ARM_R0 will result in jit_udiv() function
> being called the same dividend and divisor. Fix that by loading rn
> first into ARM_R1 and then rm into ARM_R0.
> 
> Signed-off-by: Nicolas Schichan <nschichan@freebox.fr>
> Cc: <stable@vger.kernel.org> # v3.13+
> Fixes: aee636c4809f (bpf: do not use reciprocal divide)

Applied, thank you.
