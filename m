From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 17 May 2016 12:13:34 +0100
Subject: [PATCH v2 net-next] bpf: arm64: remove callee-save registers use
 for tmp registers
In-Reply-To: <1463441786-32224-1-git-send-email-yang.shi@linaro.org>
References: <1463441786-32224-1-git-send-email-yang.shi@linaro.org>
Message-ID: <20160517111334.GD23555@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 16, 2016 at 04:36:26PM -0700, Yang Shi wrote:
> In the current implementation of ARM64 eBPF JIT, R23 and R24 are used for
> tmp registers, which are callee-saved registers. This leads to variable size
> of JIT prologue and epilogue. The latest blinding constant change prefers to
> constant size of prologue and epilogue. AAPCS reserves R9 ~ R15 for temp
> registers which not need to be saved/restored during function call. So, replace
> R23 and R24 to R10 and R11, and remove tmp_used flag to save 2 instructions for
> some jited BPF program.
> 
> CC: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Signed-off-by: Yang Shi <yang.shi@linaro.org>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
