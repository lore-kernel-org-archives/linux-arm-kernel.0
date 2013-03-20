From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 19:49:41 -0600
Subject: [PATCH v2] ARM: tegra114: add speedo-based process identification
In-Reply-To: <1363743771.3573.55.camel@dahuang-vm>
References: <1363605454-24176-1-git-send-email-dahuang@nvidia.com>
 <5148A645.9020009@wwwdotorg.org> <1363743771.3573.55.camel@dahuang-vm>
Message-ID: <514915B5.7000808@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2013 07:42 PM, Danny Huang wrote:
> On Wed, 2013-03-20 at 01:54 +0800, Stephen Warren wrote:
>> On 03/18/2013 05:17 AM, Danny Huang wrote:
>>> Add speedo-based process identifictaion for Tegra114.
>>
>> I have applied this to Tegra's for-3.10/soc branch, with one addition below:
>>
>>> diff --git a/arch/arm/mach-tegra/tegra114_speedo.c b/arch/arm/mach-tegra/tegra114_speedo.c
>>
>>> +#include <linux/kernel.h>
>>
>> Here, I also added:
>>
>> #include <linux/bug.h>
>>
>> That's not needed in the Tegra for-next branch (which is based on
>> 3.9-rc1), but is needed when merged into linux-next, and hence will
>> presumably be needed once this is submitted into 3.10.
> 
> Thanks. Does it mean that we have to include the bug.h for all newly
> created file for 3.10?

It's only needed in files that use its contents.
