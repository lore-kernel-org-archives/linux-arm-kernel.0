From: antoine.tenart@free-electrons.com (Antoine =?iso-8859-1?Q?T=E9nart?=)
Date: Wed, 23 Apr 2014 11:02:46 +0200
Subject: [PATCH v2 1/2] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
In-Reply-To: <5356A85F.6030708@gmail.com>
References: <1398155248-1659-1-git-send-email-antoine.tenart@free-electrons.com>
 <1398155248-1659-2-git-send-email-antoine.tenart@free-electrons.com>
 <5356A85F.6030708@gmail.com>
Message-ID: <20140423090246.GG24355@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sebastian,

On Tue, Apr 22, 2014 at 07:35:27PM +0200, Sebastian Hesselbarth wrote:
> On 04/22/2014 10:27 AM, Antoine T?nart wrote:

[?]

> > +		sdhci0: sdhci at ab0000 {
> > +			compatible = "mrvl,pxav3-mmc";
> > +			reg = <0xab0000 0x200>;
> > +			clocks = <&sdio1clk>;
> > +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +		};
> > +
> > +		sdhci1: sdhci at ab0800 {
> > +			compatible = "mrvl,pxav3-mmc";
> > +			reg = <0xab0800 0x200>;
> > +			clocks = <&sdio1clk>;
> > +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
> > +			status = "disabled";
> > +		};
> > +
> > +		sdhci2: sdhci at ab1000 {
> 
> Didn't Jisheng ask for sdhci2 being registered at mmc0?

Yes sure, but I don't know if he agreeded on this solution. I'll ask him.
Otherwise aliases seems ok from my point of view.

> Renaming the node labels will not help, but have you tried using an:
> 
> aliases {
> 	mmc0 = &sdhci2;
> 	mmc1 = &sdhci0;
> 	mmc2 = &sdhci1;
> };
> 
> node and set the platform_device's .id field with what you get
> from of_alias_get_id(np, "mmc")?
> 
> @Chris, Ulf: Is there any generic alias, e.g. "sdhci", you prefer for
> drivers/mmc so we can put it into sdhci_get_of_property()?

I'd also like the subsystem maintainers to give their opinion on this
before updating.

Thanks!

Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
