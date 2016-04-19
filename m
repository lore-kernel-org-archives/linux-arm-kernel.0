From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 19 Apr 2016 16:20:38 +0100
Subject: [PATCH] drivers: firmware: psci: add __init mark to
 psci_dt_cpu_init_idle
In-Reply-To: <20160419150555.GB15458@red-moon>
References: <1458657329-2484-1-git-send-email-jszhang@marvell.com>
 <20160419150555.GB15458@red-moon>
Message-ID: <57164CC6.1010201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/04/16 16:05, Lorenzo Pieralisi wrote:
> Hi Jisheng,
>
> On Tue, Mar 22, 2016 at 10:35:29PM +0800, Jisheng Zhang wrote:
>> psci_dt_cpu_init_idle() and psci_cpu_init_idle() are not needed after
>> booting, so mark them as __init.
>>

On the other hand, when I was trying to reuse arm_cpuidle_init to
support ACPI LPIs, I found that we may need to remove __init tag on it
as it gets called by hotplug notifiers in ACPI context.

I am not objecting this change, just mentioning with the hope to get
solution to the above issue.

-- 
Regards,
Sudeep
