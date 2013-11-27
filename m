From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 27 Nov 2013 09:35:58 +0530
Subject: [PATCH 07/12] memory: davinci-aemif: introduce AEMIF driver
In-Reply-To: <5294DE17.9080900@ti.com>
References: <1384187188-5776-1-git-send-email-ivan.khoronzhuk@ti.com>,
 <1384187188-5776-8-git-send-email-ivan.khoronzhuk@ti.com>
 <4F5844B3A985794BA902E12C070812375F8D2E@DNCE04.ent.ti.com>
 <52944BD3.90105@ti.com> <5294DE17.9080900@ti.com>
Message-ID: <52956FA6.8020705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 November 2013 11:14 PM, ivan.khoronzhuk wrote:

>>> +static int davinci_aemif_probe(struct platform_device *pdev)
>>> +{
>>> +       int ret  = -ENODEV, i;
>>> +       struct resource *res;
>>> +       struct device *dev = &pdev->dev;
>>> +       struct device_node *np = dev->of_node;
>>> +
>>> +       if (np == NULL)
>>> +               return 0;
>>> +
>>> +       if (aemif) {
>>> +               dev_err(dev, "davinci_aemif driver is in use currently\n");
>>> +               return -EBUSY;
>>> +       }
>>
>> Why expressly prevent multiple AEMIF devices? Its entirely conceivable
>> to have two memories like NAND and NOR flash connect to two different
>> AEMIF interfaces.
>>
> 
> It can be, but I'm not sure if it is needed. Currently I've not seen case where
> more than 2 cses were used, I mean we have 2 cs free, why do we need the second AEMIF
> controller?

One usual reason is pinmux constraints. Its probably not a concern on
the device you are working with right now but as devices get smaller,
functionality on pins is multiplexed to handle multiple different use cases.

Thanks,
Sekhar
