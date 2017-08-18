From: jeffy.chen@rock-chips.com (jeffy)
Date: Fri, 18 Aug 2017 16:32:38 +0800
Subject: [RFC PATCH v2 1/3] PCI: rockchip: Add support for pcie wake irq
In-Reply-To: <5e3accf1-6f84-861f-f647-628322bb7841@rock-chips.com>
References: <20170817120431.12398-1-jeffy.chen@rock-chips.com>
 <20170817120431.12398-2-jeffy.chen@rock-chips.com>
 <5e3accf1-6f84-861f-f647-628322bb7841@rock-chips.com>
Message-ID: <5996A626.5040303@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On 08/18/2017 03:23 PM, Shawn Lin wrote:
>>
>> @@ -1524,6 +1532,9 @@ static int rockchip_pcie_remove(struct
>> platform_device *pdev)
>>       struct device *dev = &pdev->dev;
>>       struct rockchip_pcie *rockchip = dev_get_drvdata(dev);
>> +    dev_pm_clear_wake_irq(dev);
>> +    device_init_wakeup(dev, false);
>> +
>
> Looks good overall but I think we need this on the
> error handling path of rockchip_pcie_probe as well?

hmm, right, will fix it, thanks.

and i also notice some other missing error handling, will fix them too:)
