From: weigelt@melag.de (Enrico Weigelt, metux IT consult)
Date: Fri, 29 May 2015 17:10:58 +0200
Subject: Device Tree Blob (DTB) licence
In-Reply-To: <CAOS_Y6QXHdWfi9qkRmw=mCn0mqha5-NrzumBMqJ61_YRndypLA@mail.gmail.com>
References: <1430820315.19516.26.camel@opteya.com>	<CAL_Jsq+T5c7qornpRVCduEjUSCeM+0xqbtVYovtH76y=4BqhLQ@mail.gmail.com>	<1432289148.5304.58.camel@opteya.com>	<1432322832.5304.63.camel@opteya.com>	<CAOS_Y6Q37ps+VEnzUZ_uwX++qrRm9Hgx45Q_pmiZSLSNjmKwZg@mail.gmail.com>	<55670AD4.8020705@melag.de>
 <CAOS_Y6QXHdWfi9qkRmw=mCn0mqha5-NrzumBMqJ61_YRndypLA@mail.gmail.com>
Message-ID: <55688182.3010606@melag.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.05.2015 um 05:31 schrieb Rob Landley:

 >> What's the big deal with having DTS/DTB under GPL ?
>
> One problem is that there's no such thing as "The GPL" anymore.

There are different versions. The kernel source clearly states
GPLv2 (I, personally, would prefer v3 to prevent Tivoization)

> The Linux kernel and Samba can't share code anymore,

Do they really need to ?
One could ask, whether smb support should belong into the kernel
at all (instead of, eg., going via FUSE or 9P), but that's an
entirely different discussion.

> even though they implement two ends of the same protocol, thanks to GPLv3.

Samba folks made the decision to prevent Tivoization of their code.
I fully agree with that decision, and I wish the same for the kernel.

> This seems to have badly damaged the long term viability of GPLv2,
> which used to be synonymous with copyleft (category killer license)
> and acted as a universal receiver because it was a terminal node in a
> directed graph of license convertibility reducing most licensing
> decisions to a simple binary "is it GPL compatible or not", which
> greatly appealed to developers who aren't lawyers and don't want to
> be.

Well, such things happen, if people have different views. In that case
those who want to prevent Tivoization on the one and those who wanna
allow it on the other side.

I rerely have the need to really copy-and-paste code from one project
to another. When patching existing ones, I just stick to the upstream's
license. And when starting new FOSS projects, I clearly choose (L)GPLv3,
because I'm strictly against Tivoization.

> But now a project that's "GPLv2 or later" can't accept code from
> _either_ the kernel or samba (neither provides the implicit dual
> license they need).

Well, that's a decision of the individual projects - everybody has
to live with his/her own decisions.

> Projects like QEMU are stuck between wanting to
> turn kernel drivers inside out to make device emulations (GPLv2 code)
> and grab processor definitions from gcc or binutils (GPLv3 code) and
> one project cannot accept both because GPL + GPL is a license
> conflict.

Seems to be a rare case to me. In general, I'd suggest making things
used by several distinct projects into their own distinct entities.

Note: the GPL's viral effect doesn't depend on whether the sources
are collected in one big repo, but on what is compiled-/linked-into
where.

> Of course "BSD-like" would be public domain except for 20 years of
> FUD, so they're mostly choosing one of the dozens of public domain
> equivalent licenses like the various BSDs and MIT and ISC and Apache
> that are equivalent except for "copy this license text exactly"
> clauses that cause endless license bloat over time.

It's not entirely FUD. The questions is NOT whether the original open
code will be wiped out of the net or people simply dont work on it
anymore. The main question here is, whether foss developers (often
working for free) want to help people producing non-free stuff. BSD
like to allow that, FSF folks dont. They just have different views on
that matter. IMHO, BSD folks are just interested in getting back
contributions, while FSF folks also have a broader political agenda. I,
personally, share that agenda (even more: I strongly believe that
software patents should be eradicated).

> Personally I prefer public domain equivalent licenses like CC0 or
> unlicense.org or my own "zero clause bsd", which DON'T require you to
> copy specific license text verbatim into derived works.

Well, I have an fundamentally different oppinion on that. If I publish
my code for free, I dont want assist anybody in producing non-free
stuff. (free like freedom, not free beer)

> Most of this can be laid at the door of GPLv3.

Because many folks don't wanna fight against Tivoization.
I'll have to accept that, but I don't need to coorporate.

 > Android's "no gpl in userspace" policy is why they ripped out bluez
 > and wrote a replacement bluedroid from scratch.

The really interesting question is: why do they have that policy ?
Maybe because they aren't interested in *free* (as freedom) software,
but just open source.

Otherwise they'd have an strict policy of nothing proprietary in
kernel space.

> The bluez developers keep going "if we just
> improve the code enough people will get over the license" (no really:
> https://lwn.net/Articles/597293/) but their FAQ literally doesn't
> specify _which_ GPL they're under: http://www.bluez.org/faq/common/
> (Is it the one you can't use with kernel code, the one you can't
> combine with samba code, or the or-later version that can't accept
> code from either source into its next release?

Why would one want to mix bluez code with the kernel or samba ?

> Apple's great GPL purge
> (http://meta.ath0.com/2012/02/05/apples-great-gpl-purge/)

Apple belongs to the really bad guys, what Microsoft previously was.
This is the StaSi. I have no mercy for them.

> is why we have LLVM replacing gcc, they literally stopped xcode on the last
> GPLv2 releases (gcc 4.2.1 and binutils 2.17) for over five years while
> they sponsored work on a replacement.

For xcode vs gcc, I dont really see any actual license _conflict_.
This was an political action, and we should take it as that.
Apple is against freedom. The least thing, we - the people - should
do is not helping them, not giving them a single penny.

> When samba went gplv3, they did
> http://www.osnews.com/story/24572/Apple_Ditches_SAMBA_in_Favour_of_Homegrown_Replacement
> for samba and so on.

Fine. They should do so. We don't need them. We lived happily without
them, and we'll continue to do so. SMB is just old legacy anyways,
just for interfacing with Toy-OS. (actually, I haven't had any single
Windows system for about 20 years - never missed that).

> The pro-gpl guys have tried various coercion tactics to get their way,
> which hasn't helped. The FSF sued CISCO in 2008 over the same 2003
> vendor BSP that had already been beaten out of them to produce OpenWRT
> (and remember when I said you don't sue the upstream you sue the
> individual customers when maximizing your payout?

No, you sue them for the biggest policitical impact.
Yes: it is very much about politics.

 > The BSP was from Broadcom, so the FSF sued Cisco).

CISCO distributed the devices, that's why the primary infringenment
was done by them. Of course, Boardcom should have been sued, too.

> Lesson: "These guys will never be satisifed,

No. They (more precisely: we) will be satisfied, as long as you place
by the rules. And the rules are pretty clear - just read the text.
And if you don't like these rules, just pick something else.

> The FSF also retroactively deleted binutils 2.17 (the last GPLv2
> version) off their ftp site and replaced it with a binutils 2.17a
> containing GPLv3 code, which they symlinked from the old name. (No
> really. They did the same thing with gdb 6.6 except there they didn't
> put a symlink, http://ftp.gnu.org/gnu/gdb/ .

Okay, that's a bad trick. Or just a bit stupidity.
Do we have evidence that this really was on purpose ?

> Remember how I said qemu
> wanted machine definitions they could get from _which_ two packages?

Well, they still can use the old ones. And if they patch anything there,
they're free to decide whether to dual-license or not.

> QEMU went GPLv2 only to stay compatible with the kernel.)

I haven't had a deeper look into QEMU source, but I wonder at which
places exactly it would make sense to share / transfer code from
kernel to QEMU. Any example ?

 > and don't forget what the FSF did to Mepis
> http://archive09.linux.com/articles/55285 (sued them for not mirroring
> UNMODIFIED source tarballs readily available on the upstream website).

They just were asked to comply to their part of the deal.
And as they do now, no reason for whining about it anymore.

> The kernel is grandfathered in, in part because it's always tolerated (if
 > not enjoyed) binary modules,

Actually, I strongly believe, they shouldn't be tolerated at all.

> but do you really think that if Android  decided
 > "time to switch to BSD" it would take them longer than 18 months to
 > port everything they care about? They re-port every kernel release...

Maybe. Just let them do it if they wish. I don't really care.

> I gave a talk about this at Ohio LinuxFest in 2013:
>
> outline: http://landley.net/talks/ohio-2013.txt
> audio: https://archive.org/download/OhioLinuxfest2013/24-Rob_Landley-The_Rise_and_Fall_of_Copyleft.mp3

You should learn the difference between opensource and free software.
  --> free like freedom, not free beer.

>> Important Notice: This message may contain confidential or privileged
>> information. It is intended only for the person it was addressed to. If you
>> are not the intended recipient of this email you may not copy, forward,
>> disclose or otherwise use it or any part of it in any form whatsoever. If
>> you received this email in error please notify the sender by replying and
>> delete this message and any attachments without retaining a copy.
>
> P.S. some of us actually care about licenses being appropriate to what
> they're applied to, and at least theoretically capable of being
> honored. Your email footer may be very slightly undermining your
> position here.

This is just a dumb auto-generated footer, coming from my client's
mail server over here ... I'm just too lazy for setting up an own
MTA on my workstation. You can safely ignore that.

--
Enrico Weigelt, metux IT consult
+49-151-27565287
MELAG Medizintechnik oHG Sitz Berlin Registergericht AG Charlottenburg HRA 21333 B

Wichtiger Hinweis: Diese Nachricht kann vertrauliche oder nur f?r einen begrenzten Personenkreis bestimmte Informationen enthalten. Sie ist ausschlie?lich f?r denjenigen bestimmt, an den sie gerichtet worden ist. Wenn Sie nicht der Adressat dieser E-Mail sind, d?rfen Sie diese nicht kopieren, weiterleiten, weitergeben oder sie ganz oder teilweise in irgendeiner Weise nutzen. Sollten Sie diese E-Mail irrt?mlich erhalten haben, so benachrichtigen Sie bitte den Absender, indem Sie auf diese Nachricht antworten. Bitte l?schen Sie in diesem Fall diese Nachricht und alle Anh?nge, ohne eine Kopie zu behalten.
Important Notice: This message may contain confidential or privileged information. It is intended only for the person it was addressed to. If you are not the intended recipient of this email you may not copy, forward, disclose or otherwise use it or any part of it in any form whatsoever. If you received this email in error please notify the sender by replying and delete this message and any attachments without retaining a copy.
