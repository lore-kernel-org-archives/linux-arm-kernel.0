From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 Jul 2014 20:24:05 +0100
Subject: Android and compatibility with deprecated armv7 instructions
In-Reply-To: <20140704132250.A2447C40ADD@trevor.secretlab.ca>
References: <CAOesGMh25XO=PYSSTbYkoVrQER=09mnKt68LMbLVT4+dBa716w@mail.gmail.com>
 <20140701234800.GA23577@sirena.org.uk>
 <20140702100133.GE18731@arm.com>
 <20140702163923.GJ410@sirena.org.uk>
 <20140702170141.GH24879@arm.com>
 <CACxGe6skyD-dNqR_XgqbWrwFsDs4Stwo81VQ4yviJMZK=kB8tA@mail.gmail.com>
 <20140703104135.GA28175@arm.com>
 <CACxGe6vmNamkAzvL8c5qaVEh9kvmTa=gEyr8KgBS1PW+KFc_=Q@mail.gmail.com>
 <20140703174318.GE28175@arm.com>
 <20140704132250.A2447C40ADD@trevor.secretlab.ca>
Message-ID: <20140704192405.GE14896@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 04, 2014 at 02:22:50PM +0100, Grant Likely wrote:
> On Thu, 3 Jul 2014 18:43:18 +0100, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Thu, Jul 03, 2014 at 05:22:30PM +0100, Grant Likely wrote:

> > > Welcome to system programming. This is what we do. It is a *good*
> > > thing that an x86 userspace from 1995 can still be booted.

> > I'm not sure how much of it is just the merit of Linux but rather the
> > hardware backwards compatibility. As you can see with SWP, we don't
> > always have this on ARM (and don't blame the kernel maintainers for this
> > ;)).

> > The same question again - shall we support OABI or we just add ABI
> > features based on who shouts louder?

> Yes. Listen to the people who shout. When they shout acknowledge it as a
> bug and fix it. I'll defer to rmk on the OABI question. I don't think there

Often it's also going to be reasonable to ask those complaining to
contribute code towards fixing it (or find someone who can).

> > > > library to use the new 64-bit ABI. That's perfectly fine by me, they
> > > > chose not to provide such ABI in the kernel but solve it entirely in
> > > > user space and could do the same with SWP.

> > > Really? Why would we even want that? We're far better positioned in
> > > the kernel to present the correct behaviour that any trapping from a
> > > userspace application.

> > Because by adding it to the kernel we declare it ABI (rather than just
> > an Android issue on ARMv8 hardware; I'm not currently aware of other
> > ARMv7 Linux distros affected).

> It's already an ABI. That's the point. Cat, bag, out.

> Arguing that other distros don't have the problem is bogus because it
> presumes all distros have an ISV ecosystem. Despite trying, none of them
> have been able to achieve that yet.

With distro applications it's not just ISVs you need to worry about,
it's also locally built software.  Very few people run only distro
software so either they're buying things in or they're building and
developing software themselves.  Of course in an ideal world locally
built software will be easy to rebuild and redeploy but the world isn't
always ideal.

It's probably also worth noting that the original discussion of this
that Colin referenced was started by Ming Lei from Canonical referencing
a closed application presumably running on Ubuntu so there's *some*
binary only ISV market for ARM outside of Android that's affected.

Another question I think it's worth asking is what the use case for 32
bit mode is other than preexisting binaries - I guess there's a case for
smaller binaries giving better cache utilisation?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140704/65e009f5/attachment.sig>
