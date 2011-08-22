From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 22 Aug 2011 22:09:11 +0800
Subject: 46dcfc8 (ARM: Update mach-types) removes used machine types
In-Reply-To: <20110822134823.GG2287@n2100.arm.linux.org.uk>
References: <20110822081000.GA16557@pengutronix.de>
	<201108221530.41443.marek.vasut@gmail.com>
	<20110822133242.GE2287@n2100.arm.linux.org.uk>
	<201108221536.12859.marek.vasut@gmail.com>
	<20110822134823.GG2287@n2100.arm.linux.org.uk>
Message-ID: <CAMPhdO8G3fqpiNJt4mdcK54p943Aoy37WDZH9YyJcukOGxg9=Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2011 at 9:48 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 22, 2011 at 03:36:12PM +0200, Marek Vasut wrote:
>> On Monday, August 22, 2011 03:32:42 PM Russell King - ARM Linux wrote:
>> > On Mon, Aug 22, 2011 at 03:30:41PM +0200, Marek Vasut wrote:
>> > > On Monday, August 22, 2011 03:27:19 PM Russell King - ARM Linux wrote:
>> > > > On Mon, Aug 22, 2011 at 03:16:00PM +0200, Marek Vasut wrote:
>> > > > > On Monday, August 22, 2011 03:01:19 PM Russell King - ARM Linux wrote:
>> > > > > > For further reading, see:
>> > > > > > http://lists.arm.linux.org.uk/lurker/message/20110815.085325.ae6ee0
>> > > > > > 7d.e n.ht ml
>> > > > >
>> > > > > Russell, calm down please.
>> > > > >
>> > > > > Maybe it'd be better to just email the people with broken stuff, then
>> > > > > wait ... if they don't reply in a week (two weeks?) then remove their
>> > > > > stuff. And make that a policy.
>> > > > >
>> > > > > What do you think ?
>> > > >
>> > > > Who do I email? ?Which entries are causing problems? ?That's the whole
>> > > > bloody point.
>> > >
>> > > Isn't the email in your database? You can't just script that ?
>> > >
>> > > > There's just far too much of it. ?The amount of effort required to sort
>> > > > through this file each time it needs to be updated has become
>> > > > *excessive*. The amount of effort required to go through the file and
>> > > > identify which entries are broken is *excessive*. ?The amount of
>> > > > effort required to find who to email is *excessive*.
>> > >
>> > > Why not write a script for that ?
>> >
>> > No, I don't have the time at present.
>>
>> You're the head maintainer here and ARM is a rising architecture. If you can't
>> cope with that, you have a growing community of very competent people here.
>> Maybe someone will be willing to take over eventually? It'll relieve some
>> pressure from you too, what do you think?
>
> Hello. ?Do you even understand the issue you're talking about?
>
> There is a problem _right_ _now_ with the mach-types file.
>
> That problem was caused by gplugd being merged without its entry being in
> the mach-types file - which was omitted - by way of editing by hand, along
> with shit loads of other entries - because of the fuckup with the
> machine_is_xxx() name not matching the configuration or MACH_TYPE symbol.

Grrrr.... as the original guilty one who stirred this whole pile of
sh*t up, should
I keep my mouth shut up on this?  ;-)

True that it's a stupid mistake for code to use non-matched machine entries
and it's fair to simply remove them.

Yet I guess what us sub-maintainers would like to know is the correct way
to amend this (after the incorrect entry being removed), and to better help
with "getting it right"?

>
> So, rather than wasting a *significant* amount of time hand editing the
> file at every update (which is precisely why I haven't been updating the
> bloody thing) I've built it into the script so that entries which do not
> conform are automatically omitted.
>
> Problem solved.
>
> Any remaining problems are down to the maintainers not talking to me and,
> if you haven't realised yet, I have _zero_ sympathy for that especially
> when it doesn't take much effort _on their part_ to do.
>
> It's got nothing to do with ARM being a rising architecture. ?It's about
> maintainers doing the right thing, behaving in the right way and taking
> responsibility for their fuckups. ?Putting the pain where the pain should
> be - in the platform maintainers lap, not in my lap.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
