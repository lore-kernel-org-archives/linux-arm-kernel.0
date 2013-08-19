From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 20 Aug 2013 07:13:12 +0800
Subject: [Ksummit-2013-discuss] [ARM ATTEND] Trustzone-based security
 solution for ARM Linux
In-Reply-To: <20130816110446.GA2909@localhost.localdomain>
References: <20130816110446.GA2909@localhost.localdomain>
Message-ID: <CAGsJ_4wnF4=Yi5keMtOpSzXGVVCSWoaijUyJRdvw7sayoAUgtA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/8/16 Dave Martin <Dave.Martin@arm.com>:
> On Fri, Aug 16, 2013 at 10:49:30AM +0800, Barry Song wrote:
>> [snip]
>> >
>> > Needless to say, there are multiple proprietary blobs out there which
>> > do much what you describe, though these are closed and locked down.
>> >
>> yes. i have listed [1][2][3] as examples.
>> [1]SafeG (Safety Gate): http://www.toppers.jp/en/safeg.html
>> [2]Green Hills Multivisor:
>> http://www.ghs.com/products/rtos/integrity_virtualization.html
>> [3]SierraVisor: http://www.openvirtualization.org/
>>
>> >
>> > As others have said, the Secure World is just another execution space,
>> > so there's no technical reason not to have some FOSS running in there,
>> > be it an RTOS, uClinux or Linux.
>> >
>>
>> non-security world need to know how much time is taken away from
>> security world whatewer OS security world uses.
>>
>> > However, the ways in which resources can be shared between the Secure
>> > World and Normal World are inflexible compared with the kind of sharing
>> > you get from a normal hypervisor.  The Secure World doesn't have any
>> > true virtualisation capabilities.
>> >
>>
>> except the stolen time issue, actually a high-level msg protocol like
>> virtio and RPMsg will help rich information sharing between
>> non-security and security world than a simple SMC call.
>> these communication channels are not specific to CSR chips, can be
>> re-used by all SoCs if they have similar scenarios. so i am thinking
>> whether we can have some generic framework for that in ARM Linux.
>
> Despite what I said about TZ not supporting true virtualisation, there
> are a lot similar issues.  This things you mention (IPC, timekeeping,
> blackout avoidance etc.) don't sound like unique problems.

yes. there are similar issues with a real virtualisation. here the
unique problems are callbacks and frameworks which help hook TZ into
virtualization-similar architecture without enabling the whole
virtualization in kernel. we can have a generic TZ implementation
instead of per-soc instance.

>
> I suppose this may indeed be viewed as a special, limited case of
> virtualisation, where physical memory is statically partitioned and not
> virtualised, and there is only one guest*
>
>
> I guess it would be worth getting ideas from the KVM guys about what
> concepts can be applied here, even if the code is not directly re-usable.
>

agree.

> Cheers
> ---Dave
>

-barry
