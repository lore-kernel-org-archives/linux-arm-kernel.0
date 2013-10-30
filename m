From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 30 Oct 2013 09:32:42 -0600
Subject: [GIT PULL] prefetch support for 3.13
In-Reply-To: <20131030152553.GD16735@n2100.arm.linux.org.uk>
References: <20131009171312.GJ8378@mudshark.cambridge.arm.com>
 <527124B3.9090305@nvidia.com> <20131030152553.GD16735@n2100.arm.linux.org.uk>
Message-ID: <5271269A.9080609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/30/2013 09:25 AM, Russell King - ARM Linux wrote:
> On Wed, Oct 30, 2013 at 08:24:35AM -0700, Paul Walmsley wrote:
>> Hi Will et al.,
>>
>> On 10/09/2013 10:13 AM, Will Deacon wrote:
>>> Hi Russell,
>>>
>>> Please pull the following patches for 3.13. They add support for the pldw
>>> instruction (prefetch with intent to modify) in ARMv7 SMP cores, which is
>>> then used to gain a measurable performance boost for particular atomic
>>> sequences.
>>
>> Looks like the pldw changes require binutils >= 2.21.  Might be worth  
>> considering a patch to update Documentation/Changes?
> 
> Not really - because that says "for all architectures the minimum
> requirement is now 2.21 or later" and that's certainly not the case.

By "that", do you mean the text Paul wrote? I don't think he was
suggesting that as a patch.

> It's only ARMv7 which requires this.

Wouldn't it make sense to document this still? Can't we just put a list
of minimum requirements into Documentation/Changes based on architecure,
e.g.:

o  binutils               2.21                    # ld -v (ARMv7)
o  binutils               2.12                    # ld -v (other)

At the very least, the current documentation is wrong, because there are
clearly cases where binutils-2.12 isn't sufficient.
