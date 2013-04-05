From: balbi@ti.com (Felipe Balbi)
Date: Fri, 5 Apr 2013 16:19:36 +0300
Subject: [PATCH v3 1/4] ARM: OMAP4+: PM: Consolidate MPU subsystem PM
 code for re-use
In-Reply-To: <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
References: <1365166743-5940-1-git-send-email-santosh.shilimkar@ti.com>
 <1365166743-5940-2-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130405131935.GM11464@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 05, 2013 at 06:29:00PM +0530, Santosh Shilimkar wrote:
> OMAP5 and future OMAP based SOCs has backward compatible MPUSS
> IP block with OMAP4. It's programming model is mostly similar.

s/It's/Its/
s/mostly //

(similar already expands to 'almost the same' :-)

> @@ -355,6 +389,12 @@ int __init omap4_mpuss_init(void)
>  
>  	save_l2x0_context();
>  
> +	if (cpu_is_omap44xx()) {
> +		omap_pm_ops.finish_suspend = omap4_finish_suspend;
> +		omap_pm_ops.resume = omap4_cpu_resume;
> +		omap_pm_ops.scu_prepare = scu_pwrst_prepare;
> +	}

why don't you just rename omap4_* into omap_* and add cpu-based checks
there in order to handle differences between omap4 and omap5?

If implementation will be almost the same for both, you might be able to
save on some more duplication, no ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130405/93830beb/attachment.sig>
