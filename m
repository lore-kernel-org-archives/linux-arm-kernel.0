From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Jun 2015 14:17:44 +0100
Subject: [RFC PATCH] arm64: bpf: fix endianness conversion bugs
In-Reply-To: <1435282755-12011-1-git-send-email-xi.wang@gmail.com>
References: <1435282755-12011-1-git-send-email-xi.wang@gmail.com>
Message-ID: <20150626131744.GF3078@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 25, 2015 at 06:39:15PM -0700, Xi Wang wrote:
> Upper bits should be zeroed in endianness conversion:
> 
> - even when there's no need to change endianness (i.e., BPF_FROM_BE
>   on big endian or BPF_FROM_LE on little endian);
> 
> - after rev16.
> 
> This patch fixes such bugs by emitting extra instructions to clear
> upper bits.
> 
> Cc: Zi Shen Lim <zlim.lnx@gmail.com>
> Cc: Alexei Starovoitov <ast@plumgrid.com>
> Fixes: e54bcde3d69d ("arm64: eBPF JIT compiler")
> Signed-off-by: Xi Wang <xi.wang@gmail.com>

Applied. Thanks.

-- 
Catalin
