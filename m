From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 30 Oct 2013 16:01:33 +0000
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <alpine.DEB.2.02.1310300846520.12006@tamien>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <527124B3.9090305@nvidia.com> <20131030152553.GD16735@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1310300846520.12006@tamien>
Message-ID: <20131030160133.GE16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 30, 2013 at 08:53:08AM -0700, Paul Walmsley wrote:
> Hi Russell,
>
> On Wed, 30 Oct 2013, Russell King - ARM Linux wrote:
>
>> On Wed, Oct 30, 2013 at 08:24:35AM -0700, Paul Walmsley wrote:
>>> Hi Will et al.,
>>>
>>> On 10/09/2013 10:13 AM, Will Deacon wrote:
>>>> Hi Russell,
>>>>
>>>> Please pull the following patches for 3.13. They add support for the pldw
>>>> instruction (prefetch with intent to modify) in ARMv7 SMP cores, which is
>>>> then used to gain a measurable performance boost for particular atomic
>>>> sequences.
>>>
>>> Looks like the pldw changes require binutils >= 2.21.  Might be worth
>>> considering a patch to update Documentation/Changes?
>>
>> Not really - because that says "for all architectures the minimum
>> requirement is now 2.21 or later" and that's certainly not the case.
>>
>> It's only ARMv7 which requires this.
>
> Would you consider something like the following?

I think it's up to others whether we want to start adding this level of
detail to this file.  Given that we already have x86 there, I don't see
a problem with this.

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
