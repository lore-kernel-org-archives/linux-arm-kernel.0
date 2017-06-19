From: marc_gonzalez@sigmadesigns.com (Marc Gonzalez)
Date: Mon, 19 Jun 2017 16:50:15 +0200
Subject: [PATCH v5 2/3] PCI: Add tango PCIe host bridge support
In-Reply-To: <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
References: <741766e5-cff2-db5f-d40b-6866e08fd966@sigmadesigns.com>
 <1802aae0-f97b-c437-c00e-5fa7c867286d@sigmadesigns.com>
 <654acba8-68b9-fb4c-4681-35af94b6bd74@sigmadesigns.com>
Message-ID: <6abfe9ce-5c32-9be0-e276-ed14253aa773@sigmadesigns.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/06/2017 10:19, Marc Gonzalez wrote:

> On 31/05/2017 15:33, Marc Gonzalez wrote:
> 
>> +static int tango_pcie_probe(struct platform_device *pdev)
>> +{
>> +	int ret = -EINVAL;
>> +	void __iomem *base;
>> +	struct resource *res;
>> +	struct tango_pcie *pcie;
>> +	struct device *dev = &pdev->dev;
>> +
>> +	pr_err("MAJOR ISSUE: PCIe config and mem spaces are muxed\n");
>> +	pr_err("Tainting kernel... Use driver at your own risk\n");
>> +	add_taint(TAINT_FIRMWARE_WORKAROUND, LOCKDEP_STILL_OK);
> 
> Hello Bjorn,
> 
> In v4, your only comment was
> "[muxing config and mem spaces] is a major issue and possibly even
> a security problem [which requires at least an error message and a
> kernel taint].
> 
> Were there any other issues with the host bridge support?

Hello Bjorn,

I imagine you are now only waiting for Marc Z's Ack of patch 3/3 ?
(AFAIU, all issues have been addressed as of v8 3/3.)

Rob has Acked patch 1/3 -- thanks Rob.

Assuming all issues with patch 2/3 have already been addressed,
then this driver can land in time for 4.13 right?

Regards.
