From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 29 Sep 2017 11:22:05 +0200
Subject: [PATCH] mmc: sdhci-xenon: Fix clock resource by adding an
 optional bus clock
In-Reply-To: <20170929111550.065e7948@windsurf.lan> (Thomas Petazzoni's
 message of "Fri, 29 Sep 2017 11:15:50 +0200")
References: <20170928150520.27616-1-gregory.clement@free-electrons.com>
 <20170929103943.3a6f2509@xhacker.debian>
 <87fub5hnqb.fsf@free-electrons.com>
 <20170929111550.065e7948@windsurf.lan>
Message-ID: <87bmlthnb6.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,
 
 On ven., sept. 29 2017, Thomas Petazzoni <thomas.petazzoni@free-electrons.com> wrote:

> Hello,
>
> On Fri, 29 Sep 2017 11:13:00 +0200, Gregory CLEMENT wrote:
>
>> >>  - clock-names:
>> >>    Array of names corresponding to clocks property.
>> >>    The input clock for Xenon IP core should be named as "core".
>> >> +  The input clock for the AXI bus must be named as "axi".  
>> >
>> > Is "bus" more suitable?  
>> 
>> I find bus too vague.
>
> Actually no, I believe "bus" is more common. Indeed, you could have the
> same IP, attached to a different interconnect I guess.
>
>> >>  	/*
>> >>  	 * Link Xenon specific mmc_host_ops function,
>> >> @@ -491,9 +493,20 @@ static int xenon_probe(struct platform_device *pdev)
>> >>  	if (err)
>> >>  		goto free_pltfm;
>> >>  
>> >> +	priv->axi_clk = devm_clk_get(&pdev->dev, "axi");
>> >> +	if (IS_ERR(priv->axi_clk)) {
>
> -EPROBE_DEFER handling ?


See
http://lists.infradead.org/pipermail/linux-arm-kernel/2017-September/533510.html

Gregory

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
