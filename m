From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Nov 2013 11:21:11 +0100
Subject: [PATCH 1/3] ARM: tegra: fix DEBUG_LL combined with LPAE
In-Reply-To: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131126102111.GD27752@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:36:41PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> The DEBUG_LL UART address is mapped as an MMU section, hence, the
> virtual address must be section-aligned. Sections are 1MB without LPAE
> and 2MB with LPAE. Tegra's virtual address was only aligned to 1MB, and
> hence the mapping was set up incorrectly with LPAE enabled, thus causing
> a hang early during boot. Fix this by picking a different virtual address
> that is aligned to 2MB.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> ---
>  arch/arm/include/debug/tegra.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/fb608f99/attachment-0001.sig>
