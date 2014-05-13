From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 13 May 2014 15:08:45 -0700
Subject: [PATCH 4/4] spi: qup: Add support for v1.1.1
In-Reply-To: <1400016884-9568-5-git-send-email-agross@codeaurora.org>
References: <1400016884-9568-1-git-send-email-agross@codeaurora.org>
 <1400016884-9568-5-git-send-email-agross@codeaurora.org>
Message-ID: <20140513220845.GH20486@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/13, Andy Gross wrote:
> @@ -488,7 +491,7 @@ static int spi_qup_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	struct device *dev;
>  	void __iomem *base;
> -	u32 data, max_freq, iomode;
> +	u32 data = 0, max_freq, iomode;

It looks like data is unused? But actually it's used to print a
version out and now it will always print version 0. Perhaps that
printk needs an update?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
