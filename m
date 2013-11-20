From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Nov 2013 11:22:03 -0700
Subject: [PATCH 13/31] dma: tegra: register as an OF DMA controller
In-Reply-To: <201311201628.57951.arnd@arndb.de>
References: <1384548866-13141-1-git-send-email-swarren@wwwdotorg.org>
 <1384548866-13141-14-git-send-email-swarren@wwwdotorg.org>
 <201311201628.57951.arnd@arndb.de>
Message-ID: <528CFDCB.1080200@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/20/2013 08:28 AM, Arnd Bergmann wrote:
> On Friday 15 November 2013, Stephen Warren wrote:
...
>> @@ -1383,6 +1409,10 @@ static int tegra_dma_probe(struct platform_device *pdev)
>>                 goto err_irq;
>>         }
>>  
>> +       tegra_dma_info.dma_cap = tdma->dma_dev.cap_mask;
>> +       ret = of_dma_controller_register(pdev->dev.of_node,
>> +                                        of_dma_simple_xlate, &tegra_dma_info);
>> +
> 
> I would suggest to use a custom xlate() function based on
> dma_get_slave_channel() that was added recently: Iterating through all
> channels is not necessary any more.

OK, I've converted to that locally, and will repost soon.
