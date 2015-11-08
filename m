From: okaya@codeaurora.org (Sinan Kaya)
Date: Sun, 8 Nov 2015 16:51:38 -0500
Subject: [PATCH V3 4/4] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <CAHp75VebMdGRkgddoaCH_d_7hzXJt9QXqWc4yvSY=PJ-FcsRLA@mail.gmail.com>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-5-git-send-email-okaya@codeaurora.org>
 <CAHp75VebMdGRkgddoaCH_d_7hzXJt9QXqWc4yvSY=PJ-FcsRLA@mail.gmail.com>
Message-ID: <563FC3EA.1040303@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/8/2015 3:47 PM, Andy Shevchenko wrote:
>> +       trca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> >+       if (!trca_resource) {
>> >+               rc = -ENODEV;
>> >+               goto bailout;
>> >+       }
> Why did you ignore my comment about this block?
> Remove that condition entirely.
>
>> >+
>> >+       trca = devm_ioremap_resource(&pdev->dev, trca_resource);
>> >+       if (IS_ERR(trca)) {
>> >+               rc = -ENOMEM;
>> >+               goto bailout;
>> >+       }

Sorry, I didn't quite get your comment. I thought you wanted to see 
platform_get_resource and devm_ioremap_resource together.

Which one do you want me to remove?

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
