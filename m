From: olof@lixom.net (Olof Johansson)
Date: Mon, 12 Mar 2012 18:23:53 -0700
Subject: Conflict between Versatile Express DT conversion and local timer
 updates
In-Reply-To: <20120312235951.GA31601@n2100.arm.linux.org.uk>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
 <20120312235951.GA31601@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMjt26JgySpcqVT+PsSgGq9cxQWn+msG4DSwo=2ykGz91A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Mar 12, 2012 at 4:59 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Mar 12, 2012 at 11:10:16PM +0000, Russell King - ARM Linux wrote:
>> Marc, Pawel,
>>
>> Your changes are conflicting badly. ?Seriously badly. ?So badly that I'm
>> not bothering to fix the conflicts because I can't work out what the fix
>> should be.
>>
>> You both work for the same frigging organization and yet you seem to
>> work completely independently (I really don't care if you work in
>> different departments - the fact of the matter is you're touching the
>> same code in completely different ways with zero coordination between
>> yourselves. ?That's simply broken workflow.)
>>
>> For example, Marc's deleting arch/arm/plat-versatile/localtimer.c, but
>> Pawel is modifying it to add DT support for Versatile Express. ?The
>> correct solution? ?Hell knows. ?And I don't want a solution to the merge
>> conflict. ?I want the merge conflict to go away (because I'm not frigging
>> around applying the same git-rerere immune fixes to a tree I'm regenerating
>> each night for the kernel autobuilder.)
>>
>> I'm getting conflicts in arch/arm/mach-vexpress/ct-ca9x4.c and
>> arch/arm/mach-ux500/timer.c as well, which I'm not going to bother trying
>> to sort out - the obvious solution for ux500/timer.c doesn't look right.
>>
>> I've a mind to drop the localtimer changes on the floor until after this
>> merge window, but unfortunately they're part of devel-stable so I can't.
>
> Correction: I haven't been pushing out my devel-stable branch for
> apparantly two months (according to gitweb, and no one noticed?), so I
> _could_ drop the merge of Marc's tree until the conflicts can be sanely
> resolved.

I haven't noticed because I stopped tracking your tree directly when
you were having server load issues; I tend to have kept an eye on
linux-next-level breakage instead, but probably not as close as I
should have.

Dropping Marc's branch and having him either resubmit on top of
arm-soc like the io cleanup was done, or pull it in as an early
dependency for 3.5 and stage it in an for-armsoc branch sounds like
two good options to me, with no real preference in either direction.



-Olof
