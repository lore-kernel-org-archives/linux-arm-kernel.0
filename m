From: daniel@iogearbox.net (Daniel Borkmann)
Date: Tue, 17 May 2016 13:52:19 +0200
Subject: [PATCH v2 net-next] bpf: arm64: remove callee-save registers
 use for tmp registers
In-Reply-To: <1463441786-32224-1-git-send-email-yang.shi@linaro.org>
References: <1463441786-32224-1-git-send-email-yang.shi@linaro.org>
Message-ID: <573B05F3.7000009@iogearbox.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2016 01:36 AM, Yang Shi wrote:
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

LGTM, thanks!

Acked-by: Daniel Borkmann <daniel@iogearbox.net>
