From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 28 Feb 2014 14:44:48 +0000
Subject: [RFC] ARM VM System Sepcification
In-Reply-To: <CB7DBE07-42BD-4588-AC9E-CB0BF95A811A@suse.de>
References: <20140226183454.GA14639@cbox> <11174980.YJ21cfsHoG@wuerfel>
 <5AA88E43-1A40-4409-9A56-334988483843@suse.de> <6039706.L1ZWvgjHF0@wuerfel>
 <CB7DBE07-42BD-4588-AC9E-CB0BF95A811A@suse.de>
Message-ID: <alpine.DEB.2.02.1402281436290.31489@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 28 Feb 2014, Alexander Graf wrote:
> > We will however want to boot all sorts of guests in a standardized
> > virtual environment:
> > 
> > * 32 bit Linux (since some distros don't support biarch or multiarch
> >  on arm64) for running applications that are either binary-only
> >  or not 64-bit safe.
> > * 32-bit Android
> > * big-endian Linux for running applications that are not endian-clean
> >  (typically network stuff ported from powerpc or mipseb.
> > * OS/v guests
> > * NOMMU Linux
> > * BSD based OSs
> > * QNX
> > * random other RTOSs

8<---

> * Enterprise grade Linux distribution that only supports ACPI
> * Maybe WinRT if we can convince MS to use it
> * Non-Linux with x86/ia64 heritage and thus ACPI support
> 
> If we want to run those, we need to expose ACPI tables.
> 
> Again, I think the only reasonable thing to do is to implement and expose both. That situation sucks, but we got into it ourselves ;).

I think we should have a clear idea on the purpose of this doc: is it a
spec that we expect Linux and other guest OSes to comply to if they want
to run on KVM/Xen? Or is it a document that describes the state of the
world at the beginning of 2014?

If it is a spec, then we should simply ignore non-collaborative vendors
and their products. If we know in advance that they are not going to
comply to the spec, what's the point of trying to accommodate them here?
We can always carry our workarounds and hacks in the hypervisor if we
want to run their products as guests.
