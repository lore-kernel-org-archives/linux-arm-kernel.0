From: balbi@ti.com (Felipe Balbi)
Date: Tue, 26 Jul 2011 16:18:03 +0300
Subject: [PATCH V3 04/19] OMAP3+: voltage: remove spurious pr_notice for
	debugfs
In-Reply-To: <1299338962-5602-5-git-send-email-nm@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com>
	<1299338962-5602-5-git-send-email-nm@ti.com>
Message-ID: <20110726131802.GQ32582@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 05, 2011 at 08:59:07PM +0530, Nishanth Menon wrote:
> cat of debugfs entry for vp_volt provides voltage. The additional pr_notice
> is just spam on console and provides no additional information.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

> ---
>  arch/arm/mach-omap2/voltage.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
> index 1b40aa0..53c399f 100644
> --- a/arch/arm/mach-omap2/voltage.c
> +++ b/arch/arm/mach-omap2/voltage.c
> @@ -150,7 +150,6 @@ static int vp_volt_debug_get(void *data, u64 *val)
>  	}
>  
>  	vsel = vdd->read_reg(prm_mod_offs, vdd->vp_data->voltage);
> -	pr_notice("curr_vsel = %x\n", vsel);
>  
>  	if (!vdd->pmic_info->vsel_to_uv) {
>  		pr_warning("PMIC function to convert vsel to voltage"
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110726/3e8b2b6e/attachment.sig>
