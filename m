From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 18 Apr 2013 10:30:12 +0100
Subject: [PATCH] mmc: mmci: Allow MMCI to request channels with
 information acquired from DT
In-Reply-To: <201304181125.44983.arnd@arndb.de>
References: <1366205534-25079-1-git-send-email-lee.jones@linaro.org>
 <20130418080238.GB3137@gmail.com>
 <20130418081549.GE14496@n2100.arm.linux.org.uk>
 <201304181125.44983.arnd@arndb.de>
Message-ID: <20130418093012.GI14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 18, 2013 at 11:25:44AM +0200, Arnd Bergmann wrote:
> +static void mmci_dma_setup(struct device *dev, struct mmci_host *host)
> +{
> +	const char *rxname, *txname;
> +
> +	host->dma_rx_channel = dma_request_slave_channel(dev, "rx");
> +	host->dma_tx_channel = dma_request_slave_channel(dev, "tx");
> +
> +	if (!host->dma_rx_channel && !host->dma_tx_channel) {
> +		if (host->plat && host->plat->dma_filter)
> +			mmci_dma_plat_setup(host);
> +		else
> +			dev_info(mmc_dev(host->mmc), "no DMA platform data\n");
> +			return;

You may like to fix the sillies in this patch... but yes, the above
would be better.
