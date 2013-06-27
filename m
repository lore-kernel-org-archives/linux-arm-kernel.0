From: balbi@ti.com (Felipe Balbi)
Date: Thu, 27 Jun 2013 11:44:34 +0300
Subject: [PATCH 2/4] ARM: OMAP5: clockdomain data: add init file for
 omap54xx
In-Reply-To: <1372322299-25046-3-git-send-email-t-kristo@ti.com>
References: <1372322299-25046-1-git-send-email-t-kristo@ti.com>
 <1372322299-25046-3-git-send-email-t-kristo@ti.com>
Message-ID: <20130627084434.GT15455@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jun 27, 2013 at 11:38:17AM +0300, Tero Kristo wrote:
> +	rc = clk_set_parent(abe_dpll_ref, sys_32k_ck);
> +	abe_dpll = clk_get_sys(NULL, "dpll_abe_ck");

should these two lines be swaped ?

> +	if (!rc)
> +		rc = clk_set_rate(abe_dpll, OMAP5_DPLL_ABE_DEFFREQ);
> +	if (rc)
> +		pr_err("%s: failed to configure ABE DPLL!\n", __func__);
> +
> +	return 0;

so even if (rc) you still return 0 ? Shouldn't you return rc instead ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130627/ef29b2a2/attachment.sig>
