From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 24 Mar 2015 11:26:51 +0100
Subject: [PATCH v6 10/12] soc/tegra: pmc: move to using a restart handler
In-Reply-To: <1426672363-30667-11-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
 <1426672363-30667-11-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150324102650.GB18115@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 18, 2015 at 10:52:25AM +0100, Tomeu Vizoso wrote:
> From: David Riley <davidriley@chromium.org>
> 
> The pmc driver was previously exporting tegra_pmc_restart, which was
> assigned to machine_desc.init_machine, taking precedence over the
> restart handlers registered through register_restart_handler().
> 
> Signed-off-by: David Riley <davidriley@chromium.org>
> [tomeu.vizoso at collabora.com: Rebased]
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Acked-by: Stephen Warren <swarren@nvidia.com>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  arch/arm/mach-tegra/tegra.c |  1 -
>  drivers/soc/tegra/pmc.c     | 31 +++++++++++++++++++++----------
>  2 files changed, 21 insertions(+), 11 deletions(-)

Applied with minor cleanup to the for-4.1/soc branch.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150324/57a9bb30/attachment-0001.sig>
