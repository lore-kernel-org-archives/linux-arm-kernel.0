From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 27 Nov 2013 17:59:41 +0000
Subject: [RFC PATCH 0/2] arm64: Add support for 48-bit Physical Addresses
In-Reply-To: <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
References: <1385537665-5909-1-git-send-email-mohun106@gmail.com>
 <5295D1A5.5090403@arm.com>
 <CAC8NTUXiMpjNh+GBTGcLDJ2hevskWnD6PE66ZaFxBAdUuy2nbg@mail.gmail.com>
Message-ID: <5296330D.9010801@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/11/13 15:33, Radha Mohan wrote:
> On Wed, Nov 27, 2013 at 4:34 PM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> [CC-ing the maintainers - seems odd they were not cc-ed the first place]
>>
>> On 27/11/13 07:34, mohun106 at gmail.com wrote:
>>> From: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
>>>
>>> This patch series provides an implementation of supporting 48-bit
>>> Physical Addresses for ARMv8 platforms. It is the maximum width that
>>> any ARMv8 based processor can support.
>>>
>>> The implementation extends the existing support of 40-bit PA.The kernel
>>> and user space will now be able to access 128TB each. With 4KB page size
>>> the Linux now will be using 4 levels of page tables by making use of
>>> 'pud'. And with 64KB page size the Linux will be using 3 levels of page
>>> tables.
>>>
>>> The code has been tested with LTP.
>>
>> Aside from finding out whether or not this is a useful change, this
>> breaks KVM, more specifically the way kernel pages are mapped into HYP.
>> Also, guests will still be limited to 40-bit IPAs, and the stage-2
>> output range needs to be addressed as well.
> 
> This is useful for platforms (like ours) that will use 48-bit PAs.
> Sooner or later there will
> be such processors.

So should the 4-level page table cost be unconditionally forced onto all
implementations?

> And yes, I haven't checked on KVM.

Yeah, tiny detail... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
