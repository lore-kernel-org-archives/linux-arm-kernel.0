From: will.deacon@arm.com (Will Deacon)
Date: Tue, 6 Jan 2015 13:59:42 +0000
Subject: [PATCH v2 0/2] arm64: don't call early_*map() post paging_init()
In-Reply-To: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
References: <1420551673-31416-1-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20150106135941.GA3484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 06, 2015 at 01:41:11PM +0000, Leif Lindholm wrote:
> This (tiny) series resolves a fairly serious problem with
> early_ioremap/iounmap/memremap/memunmap on arm64. These functions
> cannot safely be called after paging_init(), but the sanity check
> was not triggering.
> 
> As a result, a fixmap entry was incorrectly cleared during
> early_initcalls on arm64 UEFI systems.
> 
> 1/2 reworks the arm64 UEFI support code to not attempt these calls
> and
> 2/2 enables the sanity check
> 
> Changes since v1:
> - Rebased to v3.19-rc3
> - Added 'Fixes:' tags
> - Reworked 1/2 to restore call to efi_setup_idmap() to the original
>   location in the boot process.

Looks reasonable to me; do they need a CC stable, or is this not a problem
that matters in practice?

Will
