From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 24 Feb 2010 22:41:59 +0000
Subject: [PATCH] ARM: MMCI: support 8bit mode on the ST Micro version
In-Reply-To: <1267048189-16386-1-git-send-email-linus.walleij@stericsson.com>
References: <1267048189-16386-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100224224158.GA7095@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 10:49:49PM +0100, Linus Walleij wrote:
> +	if (host->mmc->ios.bus_width == MMC_BUS_WIDTH_8) {
> +		if (host->hw_designer == AMBA_VENDOR_ST)
> +			clk |= MCI_8BIT_BUS;
> +		else
> +			dev_err(mmc_dev(host->mmc),
> +				"8bit bus mode requested but not available\n");
> +	}

Hmm.  I don't think this is necessary - just arrange for the 8-bit
capability flag to be cleared for non-ST devices.

It might be a good idea to call this register bit 'MCI_ST_8BIT_BUS'
so that people don't mistake it as something present on all
implementations.
