From: balbi@ti.com (Felipe Balbi)
Date: Wed, 25 Feb 2015 13:08:04 -0600
Subject: [PATCHv3 03/35] ARM: OMAP2+: PRM: add generic API for
 clear_mod_irqs
In-Reply-To: <1424891085-10392-4-git-send-email-t-kristo@ti.com>
References: <1424891085-10392-1-git-send-email-t-kristo@ti.com>
 <1424891085-10392-4-git-send-email-t-kristo@ti.com>
Message-ID: <20150225190804.GM11136@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 25, 2015 at 09:04:13PM +0200, Tero Kristo wrote:
> +int omap_prm_clear_mod_irqs(s16 module, u8 regs, u32 wkst_mask)
> +{
> +	if (!prm_ll_data->clear_mod_irqs) {
> +		WARN_ONCE(1, "prm: %s: no mapping function defined\n",
> +			  __func__);

you can combine these:

	if (WARN_ONCE(!prm_ll_data->clear_mod_irqs,
		"prm: %s: no mapping function defined\n",
		__func__))

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150225/f8f94d16/attachment.sig>
