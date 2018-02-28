From: gregory.clement@bootlin.com (Gregory CLEMENT)
Date: Wed, 28 Feb 2018 16:31:16 +0100
Subject: [PATCH 2/2] PCI: armada8k: Fix clock resource by adding a
 register clock
In-Reply-To: <20180228152756.GV9418@n2100.armlinux.org.uk> (Russell King's
 message of "Wed, 28 Feb 2018 15:27:57 +0000")
References: <20180228144704.12947-1-gregory.clement@bootlin.com>
 <20180228144704.12947-3-gregory.clement@bootlin.com>
 <20180228152756.GV9418@n2100.armlinux.org.uk>
Message-ID: <878tbdf7wb.fsf@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell King,
 
 On mer., f?vr. 28 2018, Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Wed, Feb 28, 2018 at 03:47:04PM +0100, Gregory CLEMENT wrote:
>> @@ -229,6 +230,15 @@ static int armada8k_pcie_probe(struct platform_device *pdev)
>>  	if (ret)
>>  		return ret;
>>  
>> +	if (IS_ERR(pcie->clk_reg) && PTR_ERR(pcie->clk_reg) == -EPROBE_DEFER) {
>
> You do realise this is needlessly complex.
>
> Pointer errors are unique, so:
>
> 	if (pcie->clk_reg == ERR_PTR(-EPROBE_DEFER)) {
>
> will do the same thing but without the complexity.  Transforming the
> constant rather than the variable is also a good habbit to get into -
> the compiler can optimise transforms to constants, but can't with
> variables, so comparisons involving things like endian conversion
> should always be done by transforming the constant not the variable.

Thanks for the tip, I will use it in the next version.

Gregory

>
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up

-- 
Gregory Clement, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
