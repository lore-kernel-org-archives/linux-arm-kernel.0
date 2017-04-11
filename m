From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 11 Apr 2017 11:43:29 +0100
Subject: [PATCH v4 08/22] KVM: arm64: ITS: Implement
 vgic_mmio_uaccess_write_its_iidr
In-Reply-To: <5b2a8ed0-bfc7-852b-07d8-8474aef25b2a@arm.com>
References: <1490607072-21610-1-git-send-email-eric.auger@redhat.com>
 <1490607072-21610-9-git-send-email-eric.auger@redhat.com>
 <864lxzch9o.fsf@arm.com>
 <5f1423fd-8f73-364a-9cf7-b4310957e2fd@redhat.com>
 <74d62f62-c0eb-b7eb-4e3a-96b1b6d0d66d@arm.com>
 <42ca421f-3c36-2f67-1e39-ec071cea3649@redhat.com>
 <e339c732-e1da-b620-ce09-8e141d2db376@arm.com>
 <dc02a006-cef8-ac75-7cfd-5fe5c220ea22@redhat.com>
 <CAFEAcA8XYUnC6zc+EF+amX8d1fP6sTF7Bypn455QkD++RsTRJA@mail.gmail.com>
 <5b2a8ed0-bfc7-852b-07d8-8474aef25b2a@arm.com>
Message-ID: <CAFEAcA8oznK3-pmsd2xzrt+HzpM9xkkCfL-iHe4L55NOtMH8vw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 April 2017 at 11:29, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 11/04/17 11:16, Peter Maydell wrote:
>> On 11 April 2017 at 11:08, Auger Eric <eric.auger@redhat.com> wrote:
>>> On 11/04/2017 12:05, Marc Zyngier wrote:
>>>> On 10/04/17 16:17, Auger Eric wrote:
>>>>> A (v1) -> B (v1 & v2): migration OK
>>>>> B (v1 & v2) -> C (v1): migration NOK
>>>>
>>>> So what does IIDR report on B once the A->B migration has taken place?
>>>> Does it report v2?
>>>
>>> yes that was the plan
>>
>> Hmm, the IIDR value shouldn't change across a migration I think.
>> It's guest visible so the guest should see it still the same
>> value even after migration.
>
> That's my worry. But we then have a problem when this VM migrates again.
> How does userspace find out which ABI to use then?

Userspace shouldn't need to care; the idea of this scheme is
that if the kernel has to change its ABI then the kernel
is what has to deal with the change.

I think that means that if you can read the v1 format on input
you have to output it too, though.

thanks
-- PMM
