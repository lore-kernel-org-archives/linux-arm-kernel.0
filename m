From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 8 Feb 2016 14:11:31 +0000
Subject: [PATCH 1/6] irqchip: add the Alpine MSIX interrupt controller
In-Reply-To: <20160208140429.GF4117@kwain>
References: <1454922971-17405-1-git-send-email-antoine.tenart@free-electrons.com>
 <1454922971-17405-2-git-send-email-antoine.tenart@free-electrons.com>
 <56B86391.1030609@arm.com> <20160208140429.GF4117@kwain>
Message-ID: <56B8A213.2020704@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/16 14:04, Antoine Tenart wrote:
> Hi Marc,
> 
> On Mon, Feb 08, 2016 at 09:44:49AM +0000, Marc Zyngier wrote:
>> On 08/02/16 09:16, Antoine Tenart wrote:
>>> +
>>> +static struct msi_domain_info alpine_msix_domain_info = {
>>> +	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
>>> +		  MSI_FLAG_PCI_MSIX,
>>
>> You can probably add MSI_FLAG_PCI_MSI
> 
> Are you sure such a flag is available? (Or am I missing something
> obvious?).

No, I'm just confused (first patch in the morning, what did you
expect?). It looks like we consider single MSI as a given, please ignore
my rambling...

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
