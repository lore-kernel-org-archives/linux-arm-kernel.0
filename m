From: will.deacon@arm.com (Will Deacon)
Date: Mon, 13 Feb 2017 11:36:24 +0000
Subject: [PATCH/RESEND] arm64: defconfig: Enlarge CMA alignment to 2 MiB
In-Reply-To: <1486983858-11362-1-git-send-email-geert+renesas@glider.be>
References: <1486983858-11362-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20170213113624.GI1512@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 13, 2017 at 12:04:18PM +0100, Geert Uytterhoeven wrote:
> Some IOMMUs (e.g. Renesas IPMMU/VMSA) support only page sizes of 4 KiB,
> 2 MiB, and 1 GiB.
> 
> With the default setting of CONFIG_CMA_ALIGNMENT = 8, allocations larger
> than 1 MiB are aligned to a 1 MiB boundary only.  Hence a 2 MiB
> allocation may not be aligned, leading to a mapping of 512 4 KiB pages.
> 
> Increase CONFIG_CMA_ALIGNMENT to allow mapping a 2 MiB buffer using a
> single PTE, decreasing memory usage and TLB pressure.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Is this useful?

I assume you're proposing it because you see an improvement? :)

> Should there instead be different defaults in Kconfig, depending on
> enabled platform support?

I don't object to updating defconfig as a quick hack, but the right solution
is probably to make the core Kconfig default value overridable by the
architecture.

Will
