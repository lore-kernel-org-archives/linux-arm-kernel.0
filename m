From: jh80.chung@samsung.com (Jaehoon Chung)
Date: Tue, 27 Dec 2016 19:18:33 +0900
Subject: [PATCH] PCI: exynos: refactor exynos pcie driver
In-Reply-To: <58620B5A.1060900@samsung.com>
References: <CGME20161223105411epcas1p3727f726e757ec6c6d7bff04a9af40077@epcas1p3.samsung.com>
 <1482490587-13611-1-git-send-email-pankaj.dubey@samsung.com>
 <e1f37a59-b633-7b9d-cc79-dbbb00a24cda@samsung.com>
 <5860E6F7.2090703@samsung.com>
 <79b89c49-a9de-3daa-9afa-b8f36304a226@samsung.com>
 <5861CE23.9060202@samsung.com>
 <6de4bc5b-05fb-793f-d3ab-b1c6ee19cfeb@samsung.com>
 <58620B5A.1060900@samsung.com>
Message-ID: <a4200793-19dd-3727-505c-5840a8ec72bb@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Alim,

On 12/27/2016 03:34 PM, Alim Akhtar wrote:
> Hi Jaehoon,
> 
[snip]
>>
>> Ah. Right..And i'm doing the refactoring to reuse the current pci-exynos.c.
> There is a nice refactoring patch posted by Pankaj recently @
> https://lkml.org/lkml/2016/12/23/73
> I would suggest you to rebase your work on this top.

Well, i don't think so. Pankaj's patch might be good way..but i can't agree about a few point.
If based on Pankaj's patch, it's more complex..

why put the ops callback for getting clock and mem resource?

If PHY generic framework is used, it's unnecessary. because it needs to get elbi and dbi resources.
clock resources("pcie" and "pcie_bus") are general things.

If Pankaj's patch is applied, also need to make the exynos5433_pcie_* callback functions?
It doesn't make sense.

I want to know maintainer's opinion..we can just touch a little for supporting All Exynos SoCs.

Best Regards,
Jaehoon Chung

> 
>> Maybe..Today or Tomorrow..I will send the patches..At that time, could you also check them?
>> Any comments might be helpful to me! :)
>>
> Will wait for you patches :-)
> 
>> Best Regards,
>> Jaehoon Chung
>>
[snip]
