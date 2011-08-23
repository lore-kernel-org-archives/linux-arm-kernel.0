From: Ian.Jackson@eu.citrix.com (Ian Jackson)
Date: Tue, 23 Aug 2011 18:57:43 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110823174550.GJ3895@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CA+wbFdcv_BsHaVwoqgF5yx6scXOodHkKjdVtarqJwjy_GFrAJQ@mail.gmail.com>
	<20051.57581.894859.395981@mariner.uk.xensource.com>
	<20110823174550.GJ3895@n2100.arm.linux.org.uk>
Message-ID: <20051.59927.511785.371806@mariner.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux writes ("Re: ARM processor mode, kernel startup, Hyp / secure state"):
> On Tue, Aug 23, 2011 at 06:18:37PM +0100, Ian Jackson wrote:
> > Yes.  But in the future it will do, surely ?  I mean, we're working on
> > bootloader protocols and this part (to do with startup cpu states and
> > ownership of the various privilege levels) is only part of it.
> 
> No - at least not yet, and I don't see any reason why we'd ever want to
> use raw ELF.
> 
> The problem with ELF is that it carries lots of baggage around which
> platforms just don't need.  Fine if it's on a hard disk and you're
> booting a desktop, but not for embedded where space tends to be a
> premium.

Hrm, yes.

> Plus, I'd point out that _no one_ is talking about boot protocols.  Not
> outside linaro at any rate.  Which means that they're doing effective
> closed-door discussion.

I'm not sure whether by "outside linaro" you mean "outside some kind
of top secret Linaro meetings".  I went to an open meeting of Linaro
developers touching on exactly these kind of topics, and everything
was public and there was substantial interest.

I'm not a Linaro developer; but I have CC'd their boot-architecture
list which AIUI is where some of the Linaro folks were thinking of
discussing boot protocols.

Just to be clear: I don't have a particular axe to grind, except that
I would like there to be some kind of defined and reasonably stable
interface, and that obviously we (Xen.org) need that interface to
support access to Hyp mode (which is something that Linux needs too if
we are to have a properly supported KVM on ARM).

Are linux-arm-kernel at infradead and boot-architecture at linaro the right
places to try to have this conversation ?

Ian.
