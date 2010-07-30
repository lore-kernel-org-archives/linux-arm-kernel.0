From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Jul 2010 09:14:19 +0100
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <1280474636.27902.1.camel@pororo.lan>
References: <1280465905.11181.41.camel@pororo.lan>
	<20100730071805.GB29746@n2100.arm.linux.org.uk>
	<1280474636.27902.1.camel@pororo.lan>
Message-ID: <20100730081419.GA3208@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 30, 2010 at 03:23:56PM +0800, Jeremy Kerr wrote:
> Hi Russell,
> 
> > No.  This change is far too big to come via git and will cause lots of
> > conflicts.  I'm not fixing those conflicts when there's a better way
> > of handling this kind of change.  There's also the matter of new platform
> > support which your patch based approach will miss.
> > 
> > What I said about a week ago is that I wanted to do the removal of
> > .phys_io/.io_pg_offst via a script, which'll ensure that we hit
> > everything that's been merged for the next merge window.
> 
> OK, but how do you want me to submit this? Provide the other three
> patches, plus a script to remove the machine_desc fields?

This is what I said eight days ago:
| BTW, this may cause lots of conflicts from SFR when the follow-on patch
| which deletes the initializers is merged.  So rather than keeping this
| separate, it probably makes more sense for this patch to be merged into
| my tree now.
| 
| ...
| 
| BTW, it'd probably make more sense to do this as a script, something
| like this (untested):
| 
| grep -rl MACHINE_START arch/arm | xargs --no-run-if-empty \
|   sed -i '/MACHINE_START/,/MACHINE_END/ { /\.(phys_io|io_pg_offst)/d }'
| 
| as over time the number of boards, etc, will change, and there's already
| context changes with these patches caused by the memblock stuff.

My intention was to have your patch merged - as patches - into an
appropriate place in my tree, and then just before the merge window
run that script to remove all the references to phys_io/io_pg_offst,
and finally, some time later, the members from the structure.
