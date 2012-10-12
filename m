From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Fri, 12 Oct 2012 12:18:08 +0100
Subject: alignment faults in 3.6
In-Reply-To: <20121012110750.GE21164@n2100.arm.linux.org.uk> (Russell King's
 message of "Fri, 12 Oct 2012 12:07:50 +0100")
References: <20121005082439.GF4625@n2100.arm.linux.org.uk>
 <AE90C24D6B3A694183C094C60CF0A2F6026B703E@saturn3.aculab.com>
 <yw1xtxu1nfsn.fsf@unicorn.mansr.com>
 <201210120811.43290.arnd@arndb.de>
 <20121012090321.GA21164@n2100.arm.linux.org.uk>
 <yw1xhaq0nefg.fsf@unicorn.mansr.com>
 <20121012110750.GE21164@n2100.arm.linux.org.uk>
Message-ID: <yw1x8vbcndlb.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Fri, Oct 12, 2012 at 12:00:03PM +0100, M?ns Rullg?rd wrote:
>> Russell King - ARM Linux <linux@arm.linux.org.uk> writes:
>> 
>> > On Fri, Oct 12, 2012 at 08:11:42AM +0000, Arnd Bergmann wrote:
>> >> On Thursday 11 October 2012, M?ns Rullg?rd wrote:
>> >> > > But, the IP header is expected to be aligned.
>> >> > 
>> >> > Everything tells the compiler the struct is perfectly aligned.  When the
>> >> > buggy driver passes a misaligned pointer, bad things happen.
>> >> 
>> >> Would it be appropriate to add a WARN_ON_ONCE() in the alignment
>> >> fault path then?
>> 
>> I think that's an excellent idea.
>
> Well, I get the last word here and it's no.

Sadly, yes.

>> >> If all alignment faults in the kernel are caused by broken drivers,
>> >> that would at least give us some hope of finding those drivers while
>> >> at the same time not causing much overhead in the case where we need
>> >> to do the fixup in the meantime.
>> >
>> > No.  It is my understanding that various IP option processing can also
>> > cause the alignment fault handler to be invoked, even when the packet is
>> > properly aligned, and then there's jffs2/mtd which also relies upon
>> > alignment faults being fixed up.
>> 
>> As far as I'm concerned, this is all hearsay, and I've only ever heard
>> it from you.  Why can't you let those who care fix these bugs instead?
>
> You know, I'm giving you the benefit of my _knowledge_ which has been
> built over the course of the last 20 years.

How proud you sound.  Now could you say something of substance instead?

> I've been in these discussions with networking people before.  I ended
> up having to develop the alignment fault handler because of those
> discussions.  And oh look, Eric confirmed that the networking code
> isn't going to get "fixed" as you were demanding, which is exactly
> what I said.

Funny, I saw him say the exact opposite:

  So if you find an offender, please report a bug, because I can
  guarantee you we will _fix_ it.

> I've been in discussions with MTD people over these issues before, I've
> discussed this with David Woodhouse when it came up in JFFS2.  I *KNOW*
> these things.

In the same way you "know" the networking people won't fix their code,
despite them _clearly_ stating the opposite?

> You can call it hearsay if you wish, but it seems to be more accurate
> than your wild outlandish and pathetic statements.

So you're resorting to name-calling.  Not taking that bait.

-- 
M?ns Rullg?rd
mans at mansr.com
