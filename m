From: adrian.hunter@intel.com (Adrian Hunter)
Date: Thu, 31 Aug 2017 16:02:23 +0300
Subject: [PATCH 4/5] mmc: sdhci-omap: Add OMAP SDHCI driver
In-Reply-To: <c7972f00-ef62-1736-822f-ebf6822b6d33@ti.com>
References: <20170821074132.4622-1-kishon@ti.com>
 <20170821074132.4622-5-kishon@ti.com>
 <4f0a7225-1843-b353-1a2a-9adcb49554d3@intel.com>
 <c7972f00-ef62-1736-822f-ebf6822b6d33@ti.com>
Message-ID: <dfe1b4e2-bcb5-c969-efe6-7cddd0eb0bf9@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/17 16:53, Kishon Vijay Abraham I wrote:
> On Monday 28 August 2017 02:36 PM, Adrian Hunter wrote:
>> On 21/08/17 10:41, Kishon Vijay Abraham I wrote:
>>> +
>>> +static void sdhci_omap_set_clock(struct sdhci_host *host, unsigned int clock)
>>> +{
>>> +	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +	struct sdhci_omap_host *omap_host = sdhci_pltfm_priv(pltfm_host);
>>> +	unsigned long clkdiv;
>>> +
>>> +	if (!clock)
>>> +		return;
>>
>> Are you sure you don't want to stop the clock.
> 
> There is never a case where the MMC core sends a request to stop the clock.
> Maybe this check is not required at all.

It does when voltage switching e.g. mmc_set_uhs_voltage(), but host drivers
should support the possibility anyway.
