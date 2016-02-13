From: kernel@martin.sperl.org (Martin Sperl)
Date: Sat, 13 Feb 2016 09:51:21 +0100
Subject: [PATCH V2 1/3] ASoC: bcm2835: move to use the clock framework
In-Reply-To: <87bn7l3085.fsf@eliezer.anholt.net>
References: <1452602149-5875-1-git-send-email-kernel@martin.sperl.org>
 <1452602149-5875-2-git-send-email-kernel@martin.sperl.org>
 <87vb6dfjbu.fsf@eliezer.anholt.net> <56B88520.5060606@martin.sperl.org>
 <87bn7l3085.fsf@eliezer.anholt.net>
Message-ID: <A3C029B5-816E-4EC3-823D-6755ECD4773B@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> On 13.02.2016, at 01:47, Eric Anholt <eric@anholt.net> wrote:
> 
> Martin Sperl <kernel@martin.sperl.org> writes:
>> 
>> Problem is that we need the VC4 bus-address (0x7e203000),
>> which is the actual <reg> value from the device tree without any
>> mapping.
>> 
>> Not the ARM MMU visible address mappings that mem->start provides
>> (typically 0x20203000 or 0x3f203000 for bcm2836)
>> 
>> Nor the mapped address (base) available in the kernel (typically
>> 0xdc......).
> 
> Now that I've noticed the BCM2835_VCMMU_SHIFT removal, this makes sense,
> but when you put unrelated changes like this together you end up slowing
> down the review process on your patches.  Please separate it out into a
> separate commit.

OK - I agree: I really should have separated those, but as the
driver was broken for both reasons and the MMU_SHIFT was the earliest
fix I forgot about it when I got the final version for submission.

Anyway: Mark has already applied this patch on January 15th into for-next:
https://git.kernel.org/cgit/linux/kernel/git/broonie/sound.git/commit/sound/soc/bcm/bcm2835-i2s.c?h=for-next&id=517e7a1537ae4663268be5d0c0ec62c563b9fc99
so it should go into the next release...

So unless Mark wants to revert it and have two separate patches
instead, I guess we need to leave it like it is.

Martin
