From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Mar 2011 19:30:26 +0000
Subject: Updated mach-types update
In-Reply-To: <AANLkTi=C3TGRvN+eWLc+C2JHf_XRmc_s8Dp+pnGkO+j2@mail.gmail.com>
References: <20110320110322.GC16646@n2100.arm.linux.org.uk>
	<AANLkTi=C3TGRvN+eWLc+C2JHf_XRmc_s8Dp+pnGkO+j2@mail.gmail.com>
Message-ID: <20110322193026.GC17264@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 22, 2011 at 02:19:11PM +0100, Domenico Andreoli wrote:
> Hi Russell,
> 
> On Sun, Mar 20, 2011 at 12:03 PM, Russell King - ARM Linux <
> linux at arm.linux.org.uk> wrote:
> 
> >
> > What this means is that any platform in the machine database which has not
> > been submitted to mainline for 12 months since it was registered will be
> > automatically dropped from the file, and the platform maintainer will need
                                         ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > to either talk to me to get it reinstated before submission, or update the
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > entry in some way to 'freshen' it.
    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >
> 
> I think this statement matches the needs of those, like me, are trying to
> add a new board.
> My patch [0] applies but does not build any more. How does it work in this
> case?

Precisely in the way I said above - see the bit I've underlined.

Frankly, if you are a platform developer, and you are unable to submit
your code within 12 months, and stuff you need for that platform gets
dropped, that's not _our_ problem to deal with.

> I may include a new bit which adds the right entry in mach-types (so that my
> patch is actually
> buildable and testable before inclusion), in taking my patch set then you
> should drop the mach-types bit because it will be updated by you script
> later.

Or you could follow the instructions I said above.

> > This does have the potential to go wrong if people start randomly changing
> > the format of how they write the MACHINE_START() macro.  If it's not found
> > by:
> >
> > grep -rh --exclude=include --include='*.c' MACHINE_START arch/arm |
> >  grep -v '^#' | sed "s@[^(]*(\([^,]*\).*@ ('\1')@;2,\$s@^@,@"
> >
> 
> maybe it could be useful to add this regex in the top of mach-types or put
> it in scripts/ so that everybody can validate his/her changes.

Why?  It's not actually useful to anyone else as all it does is produce
a big amount of SQL-formatted stuff to indicate what's in mainline.  You
know what's in mainline already - and it's really the case that you have
to be extremely obscure to avoid it matching.

Even if it was included, it wouldn't prompt people to check that their
new stuff matches.

> anyway I would add some comment in mach-types that explains how the files is
> managed.

You mean like the comment that's in there - have you even looked at the
cut down version yet?
