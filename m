From: eric.auger@redhat.com (Auger Eric)
Date: Tue, 7 Nov 2017 17:12:12 +0100
Subject: [PATCH v5 23/26] KVM: arm/arm64: GICv4: Prevent a VM using GICv4
 from being saved
In-Reply-To: <9c1e1c92-e0fa-737f-63ab-a335b93af6da@arm.com>
References: <20171027142855.21584-1-marc.zyngier@arm.com>
 <20171027142855.21584-24-marc.zyngier@arm.com>
 <1f75a11a-41c3-71b8-6abf-4aa2962e348e@redhat.com>
 <9c1e1c92-e0fa-737f-63ab-a335b93af6da@arm.com>
Message-ID: <77d479e5-98f9-9081-a3a6-87bef1009775@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 07/11/2017 16:38, Marc Zyngier wrote:
> On 07/11/17 15:24, Auger Eric wrote:
>> Hi Marc,
>>
>> Hi Marc,
>> On 27/10/2017 16:28, Marc Zyngier wrote:
>>> The GICv4 architecture doesn't make it easy for save/restore to
>>> work, as it doesn't give any guarantee that the pending state
>>> is written into the pending table.
>>
>> I don't understand where does the limitation exactly come from. Can't we
>> use the GICR_VPENDBASER table data?
> You can't. None of the tables that are written by either the ITS or the
> redistributors are architected. All you know is that there is one bit
> per vLPI, but that's it (you don't even know which one is which).
Oh I thought the redistributor config and pending tables were fully
specified (6.1.2 and 6.1.3 of the spec), except the 1kB of the pending
table.
> 
> But that's not a big deal. I don't think you can realistically migrate a
> VM that has a directly assigned device anyway. Or can we?
No we can't except for mediated devices for which migration can be
supported.

Thanks

Eric
> 
> Thanks,
> 
> 	M.
> 
