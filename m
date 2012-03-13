From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 13 Mar 2012 10:58:33 +0000
Subject: Conflict between Versatile Express DT conversion and local timer
 updates
In-Reply-To: <20120313101525.GA569@n2100.arm.linux.org.uk>
References: <20120312231016.GC10830@n2100.arm.linux.org.uk>
 <20120312235951.GA31601@n2100.arm.linux.org.uk>
 <CAOesGMjt26JgySpcqVT+PsSgGq9cxQWn+msG4DSwo=2ykGz91A@mail.gmail.com>
 <4F5F15ED.2010602@arm.com> <20120313101525.GA569@n2100.arm.linux.org.uk>
Message-ID: <4F5F2859.5020407@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/03/12 10:15, Russell King - ARM Linux wrote:
> On Tue, Mar 13, 2012 at 09:39:57AM +0000, Marc Zyngier wrote:
>> On 13/03/12 01:23, Olof Johansson wrote:
>>> Hi,
>>>
>>> On Mon, Mar 12, 2012 at 4:59 PM, Russell King - ARM Linux
>>> <linux@arm.linux.org.uk> wrote:
>>>> On Mon, Mar 12, 2012 at 11:10:16PM +0000, Russell King - ARM Linux wrote:
>>>>> Marc, Pawel,
>>>>>
>>>>> Your changes are conflicting badly.  Seriously badly.  So badly that I'm
>>>>> not bothering to fix the conflicts because I can't work out what the fix
>>>>> should be.
>>>>>
>>>>> You both work for the same frigging organization and yet you seem to
>>>>> work completely independently (I really don't care if you work in
>>>>> different departments - the fact of the matter is you're touching the
>>>>> same code in completely different ways with zero coordination between
>>>>> yourselves.  That's simply broken workflow.)
>>>>>
>>>>> For example, Marc's deleting arch/arm/plat-versatile/localtimer.c, but
>>>>> Pawel is modifying it to add DT support for Versatile Express.  The
>>>>> correct solution?  Hell knows.  And I don't want a solution to the merge
>>>>> conflict.  I want the merge conflict to go away (because I'm not frigging
>>>>> around applying the same git-rerere immune fixes to a tree I'm regenerating
>>>>> each night for the kernel autobuilder.)
>>>>>
>>>>> I'm getting conflicts in arch/arm/mach-vexpress/ct-ca9x4.c and
>>>>> arch/arm/mach-ux500/timer.c as well, which I'm not going to bother trying
>>>>> to sort out - the obvious solution for ux500/timer.c doesn't look right.
>>>>>
>>>>> I've a mind to drop the localtimer changes on the floor until after this
>>>>> merge window, but unfortunately they're part of devel-stable so I can't.
>>>>
>>>> Correction: I haven't been pushing out my devel-stable branch for
>>>> apparantly two months (according to gitweb, and no one noticed?), so I
>>>> _could_ drop the merge of Marc's tree until the conflicts can be sanely
>>>> resolved.
>>>
>>> I haven't noticed because I stopped tracking your tree directly when
>>> you were having server load issues; I tend to have kept an eye on
>>> linux-next-level breakage instead, but probably not as close as I
>>> should have.
>>>
>>> Dropping Marc's branch and having him either resubmit on top of
>>> arm-soc like the io cleanup was done, or pull it in as an early
>>> dependency for 3.5 and stage it in an for-armsoc branch sounds like
>>> two good options to me, with no real preference in either direction.
>>
>> I'm happy to rebase my patches on anything that will make the merge
>> easier (IOW conflict-less).
>>
>> Russell, would you prefer this series to go via armsoc? This seems the
>> cleanest solution for the time being.
> 
> With a lot of these core ARM changes, there's a very fine line between
> whether they are core ARM changes or whether they're platform level
> changes (many core ARM changes will impact lots of platforms.)  I'm just
> wondering if there's any point to taking these changes through my tree.
> It seems utterly pointless if they're going to keep conflicting with
> platform stuff.

Fair enough.

Olof, Arnd: which is the most base for you to take this series?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
