From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Mar 2010 08:42:44 +0000
Subject: board/device file names, and machine names
In-Reply-To: <1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
References: <1267565398.8759.77.camel@c-dwalke-linux.qualcomm.com>
	<20100302235137.GC29715@n2100.arm.linux.org.uk>
	<1267576760.8759.164.camel@c-dwalke-linux.qualcomm.com>
Message-ID: <20100303084244.GD29715@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 02, 2010 at 04:39:20PM -0800, Daniel Walker wrote:
> On Tue, 2010-03-02 at 23:51 +0000, Russell King - ARM Linux wrote:
> > On Tue, Mar 02, 2010 at 01:29:58PM -0800, Daniel Walker wrote:
> > > So one device has at least three names (more I'm sure),
> > > 
> > > 	Passion
> > > 	Mahimahi
> > > 	Nexus One
> > > 
> > > Google has most of the code support under board files with the name
> > > mahimahi.
> > 
> > I see no reason why the internal names can't be used in the code; just
> > make the configuration option texts user-friendly so that the common
> > names for the devices are used.
> 
> The internal names are usually available before the device also.
> However, in the case above there are multiple internal names. I
> personally think the naming matter, or making the tree more readable and
> cleaner .. What do you think, does the file naming even matter?

Not really.

> > A comment at the top of the file may also help.
> > 
> > As far as filenames go, let's keep them the same for now; we can rename
> > the filenames later once stuff is merged - while git can sort out
> > subsequent _merges_ with files renamed, but what it can't do is apply
> > patches on top of renamed files.  That's just something to be aware of
> > when chosing when to rename.
> 
> I'm ok with doing renames once all the code is merged .. That's always
> been one of the options with the Google code. 

It's the option of renames - and it's not something that should be
causing all this discussion.  Git can handle it well enough that it's
not a big problem if and when it happens.

> However, we need some future direction ..

Given the amount of discussion there's already been, I'm going to come
down hard on this issue to kill the discussion.

Stick with Google's existing naming for files and interally within files.
Put a comment in the files giving all the names.  Use the common name in
the Kconfig text, and either put the internal names in the help text or
in brackets in the main option text.


Don't like it?  I'm sure there's always going to be someone who doesn't
like whatever is decided upon, so get over it.  The important thing is
that the decision is made, and that there's no further dithering over
this issue.
