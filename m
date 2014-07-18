From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Jul 2014 11:14:16 +0100
Subject: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
In-Reply-To: <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
 <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
Message-ID: <20140718101416.GB1818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 15, 2014 at 03:47:26PM +0100, Andy Lutomirski wrote:
> On Sun, Jul 13, 2014 at 1:01 PM, Andy Lutomirski <luto@amacapital.net> wrote:
> > The core mm code will provide a default gate area based on
> > FIXADDR_USER_START and FIXADDR_USER_END if
> > !defined(__HAVE_ARCH_GATE_AREA) && defined(AT_SYSINFO_EHDR).
> >
> > This default is only useful for ia64.  arm64, ppc, s390, sh, tile,
> > 64-bit UML, and x86_32 have their own code just to disable it.  arm,
> > 32-bit UML, and x86_64 have gate areas, but they have their own
> > implementations.
> >
> > This gets rid of the default and moves the code into ia64.
> >
> > This should save some code on architectures without a gate area: it's
> > now possible to inline the gate_area functions in the default case.
> 
> Can one of you pull this somewhere?  Otherwise I can put it somewhere
> stable and ask for -next inclusion, but that seems like overkill for a
> single patch.

I'd be happy to take the arm64 part, but it doesn't feel right for mm/*
changes (or changes to other archs) to go via our tree.

I'm not sure what the best approach is if you want to send this via a single
tree. Maybe you could ask akpm nicely?

Will
