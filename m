From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Mon, 9 Nov 2015 00:00:32 +0200
Subject: [PATCH V3 4/4] dma: add Qualcomm Technologies HIDMA channel driver
In-Reply-To: <563FC3EA.1040303@codeaurora.org>
References: <1446958380-23298-1-git-send-email-okaya@codeaurora.org>
 <1446958380-23298-5-git-send-email-okaya@codeaurora.org>
 <CAHp75VebMdGRkgddoaCH_d_7hzXJt9QXqWc4yvSY=PJ-FcsRLA@mail.gmail.com>
 <563FC3EA.1040303@codeaurora.org>
Message-ID: <CAHp75VdkrjzCoM9PxoatB1otz2v+UfWcwf9=ATpq_ah0UobMMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 8, 2015 at 11:51 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
>
>
> On 11/8/2015 3:47 PM, Andy Shevchenko wrote:
>>>
>>> +       trca_resource = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> >+       if (!trca_resource) {
>>> >+               rc = -ENODEV;
>>> >+               goto bailout;
>>> >+       }
>>
>> Why did you ignore my comment about this block?
>> Remove that condition entirely.
>>
>>> >+
>>> >+       trca = devm_ioremap_resource(&pdev->dev, trca_resource);
>>> >+       if (IS_ERR(trca)) {
>>> >+               rc = -ENOMEM;
>>> >+               goto bailout;
>>> >+       }
>
>
> Sorry, I didn't quite get your comment. I thought you wanted to see
> platform_get_resource and devm_ioremap_resource together.
>
> Which one do you want me to remove?

At the end you would have something like

res = platform_get_resource();
addr = devm_ioremap_resources();
if (!addr) {
?
}

-- 
With Best Regards,
Andy Shevchenko
