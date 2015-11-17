From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 17 Nov 2015 21:10:50 +0800
Subject: [PATCH v3 56/62] arm/acpi: Deny MMIO access of UART
In-Reply-To: <564B17E2.8030205@citrix.com>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-57-git-send-email-shannon.zhao@linaro.org>
 <564B17E2.8030205@citrix.com>
Message-ID: <564B275A.6060309@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/11/17 20:04, Julien Grall wrote:
> On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
>> From: Shannon Zhao <shannon.zhao@linaro.org>
>>
>> Firstly it permits full MMIO capabilities for Dom0. Then deny MMIO
>> access of UART device.
> 
> I'm nearly sure we want to deny other MMIO such as the GIC regions and SMMU.
> 
But Dom0 will not know the real GIC hardware MMIO space, how would it
map these regions? In case of wrong use?
Regarding SMMU, since it doesn't support now, so I didn't add it but it
could be added later.

-- 
Shannon
