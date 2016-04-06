From: julien.grall@arm.com (Julien Grall)
Date: Wed, 6 Apr 2016 18:49:58 +0100
Subject: [PATCH v5 0/9] arm64: Add support for KVM with ACPI
In-Reply-To: <20160406172805.GJ8961@cbox>
References: <1459769860-6629-1-git-send-email-julien.grall@arm.com>
 <20160406172805.GJ8961@cbox>
Message-ID: <57054C46.1080800@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 06/04/2016 18:28, Christoffer Dall wrote:
> On Mon, Apr 04, 2016 at 12:37:31PM +0100, Julien Grall wrote:
>> Hello,
>>
>> This patch series allows KVM to work with ACPI on ARM64.
>>
>> Currently, the firmware tables are parsed by the the virtual timer and virtual
>> GIC code in order to configure them correctly.
>>
>> However the parsing of these tables is already done in the GIC and arch timer
>> drivers. This patch series introduces new helpers to retrieve the information
>> from the different drivers in order to avoid duplication of the parsing code.
>>
>> To make the merge easier via the different trees, each patch modifies a single
>> subsystem. The suggested plan to merge the series is divided in 3 steps:
>>
>> 1) Patches #1-#2 are merged via the clocksource tree
>>     Patches #2-#6 are merged via the irqchip tree
>> 2) Patches #7-#8 are merge via the KVM tree
>> 3) Patch #9 is merged via the clocksource tree.
>>
>
> I'm not a clocksource or irqchip expert, and far from an ACPI expert,
> but this series overall looks good to me now.
>
> I guess we'll need to wait until the patches are in the clocksource and
> irqchip trees, and then merge that into the kvmarm tree, and apply patch
> 7 and 8 on top, or is there a simpler way to do this?

The simpler way would be carrying all the patches in a single tree (such 
as the KVM ARM tree). If we are going this way, I would need the ack 
from all the maintainers in this case.

Regards,

-- 
Julien Grall
