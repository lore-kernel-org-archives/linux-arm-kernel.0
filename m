From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 21 Dec 2015 16:05:51 -0600
Subject: [PATCH V10 7/7] dma: qcom_hidma: add support for object hierarchy
In-Reply-To: <CAHp75Vd-ku1E4+BWGwtL06mO7EZHFmwCvwFiAhLUVwrJHNKD7w@mail.gmail.com>
References: <1450371684-23415-1-git-send-email-okaya@codeaurora.org>
 <1450371684-23415-8-git-send-email-okaya@codeaurora.org>
 <CAHp75Vd-ku1E4+BWGwtL06mO7EZHFmwCvwFiAhLUVwrJHNKD7w@mail.gmail.com>
Message-ID: <CAOZdJXVmsb=K0CeO=AsA2zr4CSNbV+TMs3GMVTnQ1AVO2jpgzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 19, 2015 at 12:37 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>> +static int __init hidma_mgmt_of_populate_channels(struct device_node *np)
>> +{
>> +       struct platform_device *pdev_parent = of_find_device_by_node(np);
>> +       struct platform_device_info pdevinfo;
>> +       struct of_phandle_args out_irq;
>> +       struct device_node *child;
>> +       struct resource *res;
>> +       const __be32 *cell;
>
> Always BE ?

Unless things have changed, device tree properties are always in
big-endian order, even on little-endian systems.


-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
