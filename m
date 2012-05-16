From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Wed, 16 May 2012 12:25:53 +0300
Subject: [PATCH v7 3/3] MTD: atmel_nand: Update driver to support
 Programmable Multibit ECC controller
In-Reply-To: <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
References: <1337093256-19117-1-git-send-email-josh.wu@atmel.com>
 <1337093256-19117-4-git-send-email-josh.wu@atmel.com>
Message-ID: <1337160353.24809.26.camel@sauron.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-05-15 at 22:47 +0800, Josh Wu wrote:
> +	while (!(pmerrloc_readl(host->pmerrloc_base, ELISR)
> +		 & PMERRLOC_CALC_DONE))
> +		cpu_relax();

How about some kind of time-out in something goes wrong?

> +		dev_warn(host->dev, "Only 2048 page size is currently " \
> +			"supported for PMECC, rolling back to Software ECC\n");

Why do you use backslashes?


-- 
Best Regards,
Artem Bityutskiy
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120516/4f2f1bd8/attachment-0001.sig>
