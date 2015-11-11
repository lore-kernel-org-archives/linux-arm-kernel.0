From: eric.dumazet@gmail.com (Eric Dumazet)
Date: Tue, 10 Nov 2015 16:08:55 -0800
Subject: [PATCH 2/2] arm64: bpf: add BPF XADD instruction
In-Reply-To: <1447195301-16757-3-git-send-email-yang.shi@linaro.org>
References: <1447195301-16757-1-git-send-email-yang.shi@linaro.org>
 <1447195301-16757-3-git-send-email-yang.shi@linaro.org>
Message-ID: <1447200535.17135.88.camel@edumazet-glaptop2.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-11-10 at 14:41 -0800, Yang Shi wrote:
> aarch64 doesn't have native support for XADD instruction, implement it by
> the below instruction sequence:
> 
> Load (dst + off) to a register
> Add src to it
> Store it back to (dst + off)

Not really what is needed ?

See this BPF_XADD as an atomic_add() equivalent.
