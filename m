From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Nov 2013 12:13:30 +0100
Subject: [PATCH 3/3] ARM: tegra: use section-sized static mappings for
 LPAE too
In-Reply-To: <1385419003-11348-3-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
 <1385419003-11348-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131126111330.GF27752@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:36:43PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The static mappings for Tegra's PPSB and APB regions were sized at 1MB
> in order to allow mapping via sections in order to avoid burning RAM for
> PTEs. On LPAE, sections are 2MB, so the static mappings need to be
> larger in order to gain the same benefit. Set IO_{PPSB,APB}_SIZE to
> SECTION_SIZE so this adjusts automatically.
> 
> While we're fiddling with iomap.h, compress IO_{IRAM,CPU}_VIRT together
> to save virtual address space in the vmalloc region; these two regions
> are mapped using PTEs.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/mach-tegra/iomap.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/85bf1e67/attachment-0001.sig>
