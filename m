From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Fri, 29 May 2015 13:35:35 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <20150529064741.GB25351@1wt.eu>
References: <1430820315.19516.26.camel@opteya.com>
 <CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>
 <1432289148.5304.58.camel@opteya.com> <1432322832.5304.63.camel@opteya.com>
 <CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>
 <55670AD4.8020705@melag.de> <20150528133429.GD2067@n2100.arm.linux.org.uk>
 <556747E4.6070403@melag.de> <20150529064741.GB25351@1wt.eu>
Message-ID: <55684F07.7050402@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.05.2015 um 08:47 schrieb Willy Tarreau:

Hi,

>>> It's really quite simple.  Other open source projects won't touch
>>> _our_ DTB with a barge pole through fear of GPL contamination.
>>
>> Which other foss projects do you have in mind ?
>
> Any other OS that's not GPL'd and that might be able to run on the
> same board. For example FreeBSD (though that's just an example, some
> boards might be compatible with tens of OS).

IMHO, FreeBSD also ships some GPL'ed software.

As the DTS/DTB is an entirely separate entity, I don't see any
conflict or viral effect here. Of course, if they patch something
here, these patches would fall under the GPL (as with all the other
GPL'ed packages).

>> And why should they fear "poisoning" ?
>
> Search for "GPL contamination", the problem is quite common, GPL
> can turn anything GPL-compatible into GPL. So for a non-GPL project
> it's very hard to adopt GPL code.

Yes, that's the whole purpose of the GPL. The deal is pretty simple:
if you take some GPL'ed software and change it, you'll have to publish
your changes under the same rules. For entirely separate entities
(eg. dedicated programs) that's not an big issue. And for libraries,
we have LGPL.

If the DTS license would be a problem, it would be worse w/ ACPI
and any proprietary firmware/BIOSes.

>> The DTB is an entirely separate file. Just like various firmware
>> blobs, startup scripts, etc, etc.
>
> Yes, one more reason for considering whether we need to force the
> same license on it or not.

But OTOH also no need to change the dts license now.
For the integration into other (non-GPL) OS'es, it just doesn't matter.
GPL- and non-GPL software can peacefully exist on one system, if they're
not derived works.

>> Just shipping that file (be it in
>> some source tarball or in the flash of some device) doesn't make
>> everything else an derived work.
>
> It becomes quite difficult when contributors send patches which affect
> both some code and such files.

What's the big deal here ?

The dts patches will fall under GPL, the others on whichever license
the other code has.

> Keep in mind that very often a contributor doesn't care about the licenses
 > of the file he proposes changes to, he just wants to have his feature
 > merged to fix his usecase.

In that particular case, he doesn't need to - just publish the patches
under the same license as the original was.

I see the problem from a different side: certain companies simply dont
wanna play by the rules - they wanna take the benefits of FOSS (and get
it for free - like free beer), but then refuse to give anything back.
Those folks instead should buy something proprietary.

> The DTB should even not be in the kernel to start with. Since it's
> supposed to describe a board in a portable way to embed it into a
> boot loader, it should be OS-agnostic.

Aggreed at this point.
But that's IMHO an entirely different discussion.
(quite similiar to the discussion, whether udev should be bundled
or separate from systemd)

> But think of it like a BIOS on your PC.

I'd rather not think about BIOS and PC at all :p
The situation here is so ugly that I'd rather wish an own law for
enforcing these things as FOSS.

I really wish, DTS (yes source! not just binary) would replace BIOS and
ACPI completely, so I could simply run my own bootloader (eg. barebox).
Compared with x86, the ARM world (even with its thousands of different
SoCs and boards) is quite easy ;-o

> You wouldn't want to have that BIOS project driven by a single OS,

If that project would be the official Linux kernel, I'd actually be
pretty happy about that. Way better than all the UEFI crap.

> or you would be extremely careful about the possibility for other OS to
 > use it without any trouble.

Well, more careful than all these board vendors with the broken
BIOSes ... :p

 > Here people do care for the
> same things by ensuring that their work on DTB can be safely used, and
> even attractive to avoid competing designs that ruin the experience of
> users and divide developer's work.

We're just talking about one file (per board type), which is entirely
separate from the actually running OS (besides the fact, that DT-source
traditionally ships with the linux source tree).

OS vendors dont need to care about its license, just like they dont
need to care about the dozens BIOS licenses.

But board vendors need to care. And that's exactly the are which really
needs to be freed (free like freedom), because it is so vital. The whole
UEFI/TC debacle clearly shows that we *need* free firmware, because
sooner or later the boards will simply refuse to boot alternative OSes.

YES: this whole issue has a big political dimension. And that's why the
GPL had been invented in the first place. It's not just about sharing
ideas and code, it's about freedom. Goethe has written about this over
200 years ago, and today it's more valid than ever.

> Yes but in practice, operating systems have become so much complex that
> they're not a week-end project anymore, so everyone starts from something
> that already exists nowadays. Projects coexist and they need to cooperate
> to avoid seeing developers do the same work in parallel and waste their
> time doing the same work, the same mistakes, fixing the same bugs etc.

And the Linux kernel is probably the most advanced (general-use)
kernel, scaling from tiny embedded stuff to big super clusters.
The development momentum is so huge here, that it (technically) doesn't
make any sense to roll an own projects. For the DTB stuff - anybody can
just use and ship it. Even commercial vendors like Microsoft could do
that - I don't see any problem here.

I only see one practical usecase for and BSD-licensed DTS: to allow
people (eg. board vendors) to close down their own branch. And that's
exactly what the GPL shall prevent.

> When you're a developer and you're scratching your head wondering if
> you are taking legal risks by adopting some code, if you see that simply
> writing your own code fixes your doubts,

I *am* an developer, and I know how the GPL works. And I *am* often
developing for my customers. License problems with FOSS licenses just
arise when you're going to mix code under different licenes or link
libraries. Both aren't the case for DTS.

Except for one scenario: if you want to compile-in the DTB into some
proprietary blob. I'd consider that an invalid usecase. Technically
a bad idea. One might wanna do that for just one reason: to make
hard for other people (IOW: the folks who buy the devices, therefore
then are the *owners* of them). And that's exactly GPL shall prevent.

 > you tend to prefer that way because most developers are not lawyers

I'm also not a lawyer. But, as my math teacher, back in school,
used to say: read the text.

It's really not that complicated at all, once you got used to the
language - basicly just like learning a new programming language.
In fact, legal stuff and software engineering is pretty much the same
(legal systems just tend to have a higher grade of indeterminism)
Actually, I know lots of former lawyers who're now software engineers
and vice versa. Oh, and legal hacking can be great fun ;-)

 > and don't have the money to consult them.

Not necessary. Better spend some time and study the texts yourself,
instead of just blindly trusting somebody else's oppinion. Not so
different from reading source code.

And I'd highly recommend everybody to do that - even for daily life.

(oh, and if anybody likes to have some tips here, feel free to ask.
I can't give any real legal advice, as some still practised Nazi
law forbids that, if you're not an licensed attourney)

> I think you don't get it : the ugly route as you say could be seen as
> still better than the trouble they're scared about. Now you can probably
> understand how scary it is if they'd prefer that ugly route.

I'm not scared about that at all, and I don't see why anybody should be.
If some board vendor (as already done in x86 world) goes the ACPI route,
we can either reverse engineer the stuff (and write proper DTS'es) or
simply boycott their products, let them starve.

> Nobody's talking about making stuff proprietary,

But thats the big danger with licenses that allow closing down
the source.

> just helping friend projects adopt our work, creating de-facto standards
 > and avoid fragmentation.

In case of DTS/DTB, there's no need for changing the license for
that purpose - it's an separate entity anyways.

> In fact proprietary stuff is often the result of a failure to
 > standardize something.

Sure. But often, it's just the pure unwillingness for cooperation.
BSD license easily allows that - you dont need to publish your changes.
Most of the time, such decisions are made by people, who know nothing
about software engineering. If we have an viral copyleft license, like
GPL, those people are quite easy to convince (especially regarding the
fact, that the companies in question usually aren't software vendors)

> When you're a board vendor and you see that everyone is using the same DTB,
 > and you want to improve it, you know that simply sending your update
 > to a few projects will be enough to make it propagate everywhere.

Yes, and exactly that works pretty fine. *With* GPL.
Most of my clients wouldn't do this on their own, if there wasn't
an legal requirement.

> Ah ? Have you got the source of the BootRom code of the SoC on your
> board to ensure it loads your bootloader as you expect it to and that
> it doesn't recognize a signature and jumps to a different address or
> whatever ?

There isn't anything like that on my SoC. It has some tiny logic
(in cpu microcode), which just reads a few blocks via SPI (emmc,
sd, etc, depending on some pin configurations) and directly jumps
into it. The boodloader is barebox, with some own patches, compiled
own my own.

That's how I also would like to have it on x86.

> When you buy some hardware, it comes with some interfacing with software,
 > and you have to trust that interface at some point,

Well, it obviously needs some specified interface (eg. CPU's opcodes,
register specs on perhiphals, etc, etc). If I don't get the proper specs
for that, it's pretty much useless for me.

For example, on my current mx53 system, I can't use the GPUs due to lack
of specs.

 > or you build your own hardware, CPU etc.

Actually, that's already in the pipeline. Will be an entirely
different architecture, more like a huge transputer grid ... but that's
going to be off-topic ...

> This interface can be very low level (eg: CPU jumps to 0xffff0000 upon reset),
 > run a little bit of code to initialize some on-chip controllers and

Yes, and I need to know exactly how to do that initialization, so I can
put my own firmware/bootloader in here. Maybe even an XIP kernel.

> You have to decide what's acceptable to you. We all do that.

Yes, and I made the decision, that I can't tolerate any proprietary
code - not on mission critical embedded systems.


cu
--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
