From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 3 Jan 2017 20:12:42 -0500 (EST)
Subject: [PATCH 1/2] arm: Cleanup sanity_check_meminfo
In-Reply-To: <1483477010-18986-2-git-send-email-labbott@redhat.com>
References: <1483477010-18986-1-git-send-email-labbott@redhat.com>
 <1483477010-18986-2-git-send-email-labbott@redhat.com>
Message-ID: <alpine.LFD.2.20.1701031958100.21662@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 3 Jan 2017, Laura Abbott wrote:

> 
> The logic for sanity_check_meminfo has become difficult to
> follow. Clean up the code so it's more obvious what the code
> is actually trying to do.

Absolutely. This function has a long history of subtle bugs ... and 
broken fixes.

> +		if (reg->base < vmalloc_limit) {
> +			if (block_end > arm_lowmem_limit)
> +				arm_lowmem_limit = min(
> +						(phys_addr_t)vmalloc_limit,
> +						block_end);

Just to illustrate how subtle this can be, the above would reintroduce a 
bug that was fixed in commit b9a019899f.


Nicolas
