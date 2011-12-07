From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 7 Dec 2011 08:49:58 +0000
Subject: [PATCH 1/2] [media] V4L: atmel-isi: add code to enable/disable
 ISI_MCK clock
In-Reply-To: <1322647604-30662-1-git-send-email-josh.wu@atmel.com>
References: <1322647604-30662-1-git-send-email-josh.wu@atmel.com>
Message-ID: <20111207084958.GA14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 06:06:43PM +0800, Josh Wu wrote:
> +	/* Get ISI_MCK, provided by programmable clock or external clock */
> +	isi->mck = clk_get(dev, "isi_mck");
> +	if (IS_ERR_OR_NULL(isi->mck)) {

This should be IS_ERR()

> +		dev_err(dev, "Failed to get isi_mck\n");
> +		ret = isi->mck ? PTR_ERR(isi->mck) : -EINVAL;

		ret = PTR_ERR(isi->mck);
