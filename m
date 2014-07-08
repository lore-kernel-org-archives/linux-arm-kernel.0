From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 8 Jul 2014 16:38:45 +0300
Subject: [PATCH v2 6/7] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <20140708132216.GA4979@htj.dyndns.org>
References: <1403101406-15439-1-git-send-email-mperttunen@nvidia.com>
 <1403101406-15439-7-git-send-email-mperttunen@nvidia.com>
 <20140708132216.GA4979@htj.dyndns.org>
Message-ID: <53BBF465.1050202@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks, I'll fix these.

On 08/07/14 16:22, Tejun Heo wrote:
> (cc'ing Hans)
>
> Hans, can you please review this patch?
>
> On Wed, Jun 18, 2014 at 05:23:25PM +0300, Mikko Perttunen wrote:
>> +#define SATA_CONFIGURATION_0				0x180
>> +#define		SATA_CONFIGURATION_EN_FPCI		BIT(0)
>
> Let's just indent uniformly.  The new line should give enough visual
> hint on grouping.
>
>> +struct tegra_ahci_priv {
>> +	struct platform_device *pdev;
>> +	void __iomem *sata_regs;
>> +	struct reset_control *sata_rst;
>> +	struct reset_control *sata_oob_rst;
>> +	struct reset_control *sata_cold_rst;
>> +	struct clk *sata_clk;
>> +	struct clk *sata_oob_clk;
>> +	struct clk *cml1_clk;
>> +	struct clk *plle_clk;
>> +	struct regulator_bulk_data supplies[5];
>> +	struct phy *padctl_phy;
>> +};
>
> And please indent the declared fields uniformly too.
>
> Except for the above nitpicks, generally looks good to me but let's
> wait for Hans' review.
>
> Thanks.
>
