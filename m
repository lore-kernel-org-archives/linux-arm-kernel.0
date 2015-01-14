From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 14 Jan 2015 10:19:18 +0000
Subject: [PATCH v2 3/8] PCI/MSI: of: Add support for OF-provided msi_domain
In-Reply-To: <54B62609.7020002@huawei.com>
References: <1420736772-11088-1-git-send-email-marc.zyngier@arm.com>
 <1420736772-11088-4-git-send-email-marc.zyngier@arm.com>
 <54B62609.7020002@huawei.com>
Message-ID: <54B642A6.7040201@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Abel,

On 14/01/15 08:17, Yun Wu (Abel) wrote:
> On 2015/1/9 1:06, Marc Zyngier wrote:
> 
>> In order to populate the PHB msi_domain, use the "msi-parent"
>> attribute to lookup a corresponding irq domain. If found,
>> this is our MSI domain.
>>
>> This gets plugged into the core PCI code.
>>
> 
> Hi Marc,
> 
> Since the whole patch series based on the fact that non PCI type
> buses will use MSI-like interrupts, would it be better if getting
> this field settled during OF populating?

Are you're thinking of letting random platform devices automagically
gain an MSI domain as they are discovered by DT? I feel like you looking
at it the wrong way.

Note that DT discovery doesn't imply a particular bus, and non-PCI
doesn't mean bus-agnostic. MSI-like interrupts really are a bus
property, and I'd rather see you implementing support for your favourite
bus (and do the MSI domain matching there).

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
