From: james.morse@arm.com (James Morse)
Date: Wed, 21 Nov 2018 11:15:44 +0000
Subject: [PATCH 2/7] arm64: sdei: Always use sdei stack for sdei events
In-Reply-To: <20181107215844.GC12248@brain-police>
References: <1537970184-44348-1-git-send-email-julien.thierry@arm.com>
 <1537970184-44348-3-git-send-email-julien.thierry@arm.com>
 <20181107215844.GC12248@brain-police>
Message-ID: <80b48de5-6495-1da9-3555-78095daf3464@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

On 07/11/2018 21:58, Will Deacon wrote:
> On Wed, Sep 26, 2018 at 02:56:19PM +0100, Julien Thierry wrote:
>> SDEI events can occur at any point, including when the stack pointer is
>> not aligned. SP could be modified to respect alignment 16-byte alignement,
>> but there is a need to deal with code using SP as scratch register.
>>
>> Always reserve the SDEI stacks to handle its events.
>>
>> Since stack allocation relies on VMAPed stacks, lets make SDEI depend on
>> VMAP_STACK.

> One side-effect of this change is that SDEI cannot be enabled in conjunction
> with KASAN. James -- are you ok with that?

So it does. I don't think this matters, the only SDEI users in the short-term
can be exercised by other notifications.
I mean to make the stacks for this thing dynamically allocated (so its less of a
memory hog), I can fix this KASAN hole at the same time.


Thanks,

James
