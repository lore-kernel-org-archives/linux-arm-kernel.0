From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Nov 2015 17:00:16 +0000
Subject: [PATCH] arm64: bpf: fix mod-by-zero case
In-Reply-To: <1446698639-12362-1-git-send-email-zlim.lnx@gmail.com>
References: <1446698639-12362-1-git-send-email-zlim.lnx@gmail.com>
Message-ID: <20151106170015.GB7637@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 04, 2015 at 08:43:59PM -0800, Zi Shen Lim wrote:
> Turns out in the case of modulo by zero in a BPF program:
> 	A = A % X;  (X == 0)
> the expected behavior is to terminate with return value 0.
> 
> The bug in JIT is exposed by a new test case [1].
> 
> [1] https://lkml.org/lkml/2015/11/4/499
> 
> Signed-off-by: Zi Shen Lim <zlim.lnx@gmail.com>
> Reported-by: Yang Shi <yang.shi@linaro.org>
> Reported-by: Xi Wang <xi.wang@gmail.com>
> CC: Alexei Starovoitov <ast@plumgrid.com>
> CC: Catalin Marinas <catalin.marinas@arm.com>
> Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
> Cc: <stable@vger.kernel.org> # 3.18+
> ---
> This patch applies on top of "arm64: bpf: fix fiv-by-zero case" [2].

Both patches applied. Thanks.

-- 
Catalin
