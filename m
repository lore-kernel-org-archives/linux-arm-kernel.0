From: suravee.suthikulpanit@amd.com (Suravee Suthikulanit)
Date: Wed, 29 Jan 2014 11:57:16 -0600
Subject: [PATCH v2 08/11] of: Increase MAX_PHANDLE_ARGS
In-Reply-To: <20140129172932.GQ26622@mudshark.cambridge.arm.com>
References: <1389876263-25759-1-git-send-email-andreas.herrmann@calxeda.com>
 <1389876263-25759-9-git-send-email-andreas.herrmann@calxeda.com>
 <20140117110830.GW3471@alberich> <52E92842.3000001@amd.com>
 <CAL_JsqLhzp5jUJPA91rNkQ07kCDYCDZLxw8LxxFEVP9b12e1Jw@mail.gmail.com>
 <52E93360.1000904@amd.com> <20140129171611.GB13543@alberich>
 <52E939CB.1020705@amd.com>
 <20140129172932.GQ26622@mudshark.cambridge.arm.com>
Message-ID: <52E940FC.9050602@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/29/2014 11:29 AM, Will Deacon wrote:
> On Wed, Jan 29, 2014 at 05:26:35PM +0000, Suravee Suthikulanit wrote:
>> On 1/29/2014 11:16 AM, Andreas Herrmann wrote:
>>> On Wed, Jan 29, 2014 at 11:59:12AM -0500, Suravee Suthikulanit wrote:
>>>> Actually, we are using 32 on the AMD system. So, do you think we can set
>>>> this to 32 instead?
>>>
>>> I think that's ok.
>>>
>>> But are we really talking about number of SMRs or number of StreamIDs
>>> per master device here? Ie. are you just having 32 SMRs for an SMMU on
>>> your AMD system or do you have master devices which have 32 StreamIDs?
>>>
>>> If it's just number of SMRs we don't need to modify this macro.
>>>
>>
>> I am referring to the case where each mmu-master can have upto 32 streamID.
>
> Crikey, how many SMRs do you have? Andreas and I have been struggling to
> write a decent allocator for those, so if you have any algorithms that don't
> require a quantum computer, we'd love to hear from you :)!
>
> Will
>

Are you talking about the __arm_smmu_alloc_bitmap()?

Currently, we have configured the each SMMU to have 32 SMRs and using 
15-bit streamID. However, we mostly have upto 32 streamID for each 
master, and most of the SMMU only have one master.  So it looks like the 
current logic should be ok.

Suravee
