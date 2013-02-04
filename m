From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 04 Feb 2013 10:31:28 +0200
Subject: [PATCH 1/2] mtd: gpmi: set the Golois Field bit for mx6q's BCH
In-Reply-To: <1359093848-22301-1-git-send-email-b32955@freescale.com>
References: <1359093848-22301-1-git-send-email-b32955@freescale.com>
Message-ID: <1359966688.13791.16.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2013-01-25 at 14:04 +0800, Huang Shijie wrote:
> +#define BF_BCH_FLASH0LAYOUT0_GF(v, x)				\
> +	((GPMI_IS_MX6Q(x) && ((v) == 14))			\
> +		? (((1) << MX6Q_BP_BCH_FLASH0LAYOUT0_GF_13_14)	\
> +			& MX6Q_BM_BCH_FLASH0LAYOUT0_GF_13_14)	\
> +		: 0						\
> +	)

Did you consider using static inline functions instead of macro
definitions? The added value would be at least type-checking. You would
also probably use names better than "v" and "x", you could even have
commentaries. Please, consider doing this.

Anyway, pushed to l2-mtd.git, thanks!

-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130204/e454a403/attachment.sig>
