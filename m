From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 13 Feb 2014 08:19:02 +0100
Subject: [PATCH 08/14] net: axienet: Removed checkpatch errors/warnings
In-Reply-To: <1392251494.2214.11.camel@joe-AO722>
References: <cover.1392220536.git.michal.simek@xilinx.com>
 <75b669c0a947effe74b291093abfa8c71f83736a.1392220536.git.michal.simek@xilinx.com>
 <1392251494.2214.11.camel@joe-AO722>
Message-ID: <ff5b1f6a-a6a7-405c-9e83-59ad33852b93@TX2EHSMHS044.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On 02/13/2014 01:31 AM, Joe Perches wrote:
> On Wed, 2014-02-12 at 16:55 +0100, Michal Simek wrote:
>> From: Srikanth Thokala <srikanth.thokala@xilinx.com>
> 
> trivia:
> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> 
>> +			netdev_err(lp->ndev,
>> +				"axienet_device_reset DMA reset timeout!\n");
> 
> could you please align multi-line arguments to the
> appropriate open parenthesis?
> 
> 			netdev_err(lp->ndev,
> 				   "axienet_device_reset DMA reset timeout!\n");
> 
> or maybe:
> 
> 			netdev_err(lp->ndev, "%s: "DMA reset timeout!\n",
> 				   __func__);

ok.

> 
>> @@ -484,8 +484,8 @@ static void axienet_device_reset(struct net_device *ndev)
>>  	}
>>
>>  	if (axienet_dma_bd_init(ndev)) {
>> -		dev_err(&ndev->dev, "axienet_device_reset descriptor "
>> -			"allocation failed\n");
>> +		netdev_err(ndev,
>> +			"axienet_device_reset descriptor allocation failed\n");
> 
> etc, et al.


ok.

> 
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c b/drivers/net/ethernet/xilinx/xilinx_axienet_mdio.c
> []
>> @@ -161,19 +161,19 @@ int axienet_mdio_setup(struct axienet_local *lp, struct device_node *np)
>>
>>  	np1 = of_find_node_by_name(NULL, "cpu");
>>  	if (!np1) {
>> -		printk(KERN_WARNING "%s(): Could not find CPU device node.",
>> -		       __func__);
>> -		printk(KERN_WARNING "Setting MDIO clock divisor to "
>> -		       "default %d\n", DEFAULT_CLOCK_DIVISOR);
>> +		netdev_warn(lp->ndev, "Could not find CPU device node.");
> 
> missing trailing "\n" to terminate message.

ok.

> 
>> +		netdev_warn(lp->ndev,
>> +			 "Could not find clock ethernet controller property.");
> 
> here too. (and alignment)

This is problematic. I would like to keep 80 char limits and keeping
this align just break it. That's why I was using tab alignment.
Probably the solution is just to shorten message.

Thanks for your comments,
Michal
