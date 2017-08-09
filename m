From: david.wu@rock-chips.com (David.Wu)
Date: Wed, 9 Aug 2017 15:01:16 +0800
Subject: [PATCH v3 01/11] net: phy: Add rockchip phy driver support
In-Reply-To: <20170802132121.GA24708@lunn.ch>
References: <1501654546-17292-1-git-send-email-david.wu@rock-chips.com>
 <1501654546-17292-2-git-send-email-david.wu@rock-chips.com>
 <20170802132121.GA24708@lunn.ch>
Message-ID: <4cfa1cbc-d3a9-d27a-ecd3-2285d6e498a7@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

? 2017/8/2 21:21, Andrew Lunn ??:
>> +static struct phy_driver rockchip_phy_driver[] = {
>> +{
>> +	.phy_id			= 0x1234d400,
>> +	.phy_id_mask		= 0xfffffff0,
>> +	.name			= "Rockchip internal EPHY",
>> +	.features		= (PHY_BASIC_FEATURES | SUPPORTED_Pause
>> +				   | SUPPORTED_Asym_Pause),
> 
> Please take a look at Documentation/networking/phy.txt and
> Fixes: 529ed1275263 ("net: phy: phy drivers should not set SUPPORTED_[Asym_]Pause")
> 
> Pause frames / flow control
> 
>   The PHY does not participate directly in flow control/pause frames except by
>   making sure that the SUPPORTED_Pause and SUPPORTED_AsymPause bits are set in
>   MII_ADVERTISE to indicate towards the link partner that the Ethernet MAC
>   controller supports such a thing. Since flow control/pause frames generation
>   involves the Ethernet MAC driver, it is recommended that this driver takes care
>   of properly indicating advertisement and support for such features by setting
>   the SUPPORTED_Pause and SUPPORTED_AsymPause bits accordingly. This can be done
>   either before or after phy_connect() and/or as a result of implementing the
>   ethtool::set_pauseparam feature.
> 

Thanks for the reminder, I'll remove it.

> 	Andrew
> 
> 
> 
