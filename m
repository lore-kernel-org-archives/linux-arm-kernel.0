From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Oct 2018 17:57:41 +0100
Subject: [PATCH] arm64: mm: Use __pa_symbol() for set_swapper_pgd()
In-Reply-To: <20181010144322.14363-1-james.morse@arm.com>
References: <20181010144322.14363-1-james.morse@arm.com>
Message-ID: <20181010165740.GD212880@arrakis.emea.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 03:43:22PM +0100, James Morse wrote:
> commit 2330b7ca78350efcb ("arm64/mm: use fixmap to modify
> swapper_pg_dir") modifies the swapper_pg_dir via the fixmap
> as the kernel page tables have been moved to a read-only
> part of the kernel mapping.
> 
> Using __pa() to setup the fixmap causes CONFIG_DEBUG_VIRTUAL
> to fire, as this function is used on the kernel-image swapper
> address. The in_swapper_pgdir() test before each call of this
> function means set_swapper_pgd() will only ever be called when
> pgdp points somewhere in the kernel-image mapping of
> swapper_pd_dir. Use __pa_symbol().
> 
> Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: James Morse <james.morse@arm.com>
> CC: Jun Yao <yaojun8558363@gmail.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied. Thanks.

-- 
Catalin
