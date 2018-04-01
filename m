From: neil.m.leeder@gmail.com (Neil Leeder)
Date: Sun, 1 Apr 2018 01:44:41 -0400
Subject: [PATCH 2/2] perf: add arm64 smmuv3 pmu driver
In-Reply-To: <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
References: <1501876754-1064-1-git-send-email-nleeder@codeaurora.org>
 <1501876754-1064-3-git-send-email-nleeder@codeaurora.org>
 <883d32ce-6581-ecf6-5088-ecb238322ebe@huawei.com>
 <e55ab4404143ea0b3cc4795a93e37480@codeaurora.org>
Message-ID: <14f90cc6-f2c1-5a63-67c6-a5c8ddb4799e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yisheng Xie,

On 3/29/2018 03:03 AM, Yisheng Xie wrote:
> 
> Hi Neil,
> 
> On 2017/8/5 3:59, Neil Leeder wrote:
>> +??? mem_resource_0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +??? mem_map_0 = devm_ioremap_resource(&pdev->dev, mem_resource_0);
>> +
> Can we use devm_ioremap instead? for the reg_base of smmu_pmu is
> IMPLEMENTATION DEFINED. If the reg of smmu_pmu is inside smmu,
> devm_ioremap_resource will failed and return -EBUSY, eg.:
> 
>  ?smmu reg ranges:??????? 0x180000000 ~ 0x1801fffff
>  ?its smmu_pmu reg ranges:??? 0x180001000 ~ 0x180001fff
> 
Just to let you know that I no longer work at Qualcomm and I won't be 
able to provide updates to this patchset. I expect that others from my 
former team at Qualcomm will pick up ownership.

Neil
