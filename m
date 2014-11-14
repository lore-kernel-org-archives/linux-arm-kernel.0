From: balbi@ti.com (Felipe Balbi)
Date: Fri, 14 Nov 2014 11:41:52 -0600
Subject: [RFC PATCH 2/3] mmc: omap_hsmmc: add tuning support
In-Reply-To: <1415883379-19654-3-git-send-email-kishon@ti.com>
References: <1415883379-19654-1-git-send-email-kishon@ti.com>
 <1415883379-19654-3-git-send-email-kishon@ti.com>
Message-ID: <20141114174152.GM11538@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Nov 13, 2014 at 06:26:18PM +0530, Kishon Vijay Abraham I wrote:
> @@ -233,6 +263,48 @@ struct omap_mmc_of_data {
>  	u8 controller_flags;
>  };
>  
> +static const u32 ref_tuning_4bits[] = {
> +	0x00FF0FFF, 0xCCC3CCFF, 0xFFCC3CC3, 0xEFFEFFFE,
> +	0xDDFFDFFF, 0xFBFFFBFF, 0xFF7FFFBF, 0xEFBDF777,
> +	0xF0FFF0FF, 0x3CCCFC0F, 0xCFCC33CC, 0xEEFFEFFF,
> +	0xFDFFFDFF, 0xFFBFFFDF, 0xFFF7FFBB, 0xDE7B7FF7
> +};
> +
> +static const u32 ref_tuning_8bits[] = {
> +	0xFF00FFFF, 0x0000FFFF, 0xCCCCFFFF, 0xCCCC33CC,
> +	0xCC3333CC, 0xFFFFCCCC, 0xFFFFEEFF, 0xFFEEEEFF,
> +	0xFFDDFFFF, 0xDDDDFFFF, 0xBBFFFFFF, 0xBBFFFFFF,
> +	0xFFFFFFBB, 0XFFFFFF77, 0x77FF7777, 0xFFEEDDBB,
> +	0x00FFFFFF, 0x00FFFFFF, 0xCCFFFF00, 0xCC33CCCC,
> +	0x3333CCCC, 0xFFCCCCCC, 0xFFEEFFFF, 0xEEEEFFFF,
> +	0xDDFFFFFF, 0xDDFFFFFF, 0xFFFFFFDD, 0XFFFFFFBB,
> +	0xFFFFBBBB, 0xFFFF77FF, 0xFF7777FF, 0xEEDDBB77
> +};

yet another feature we would've gotten for free if we were already using
sdhci. This is just a copy of what's on sdhci-msm.c, probably because
they license the same IP we do.

It would be much better to just convert omap-hsmmc.c into sdhci-omap.c
much like it was done for 8250-omap.c, with the added benefit that this
will incur no userland regressions due to devnode names.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141114/fbafeeea/attachment.sig>
