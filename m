From: nico@fluxnic.net (Nicolas Pitre)
Date: Fri, 30 Jul 2010 21:46:16 -0400 (EDT)
Subject: [GIT PULL] debug macro changes for 2.6.36
In-Reply-To: <20100730081419.GA3208@n2100.arm.linux.org.uk>
References: <1280465905.11181.41.camel@pororo.lan>
	<20100730071805.GB29746@n2100.arm.linux.org.uk>
	<1280474636.27902.1.camel@pororo.lan>
	<20100730081419.GA3208@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.00.1007302138380.30558@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 30 Jul 2010, Russell King - ARM Linux wrote:

> This is what I said eight days ago:
> | BTW, this may cause lots of conflicts from SFR when the follow-on patch
> | which deletes the initializers is merged.  So rather than keeping this
> | separate, it probably makes more sense for this patch to be merged into
> | my tree now.
> | 
> | ...
> | 
> | BTW, it'd probably make more sense to do this as a script, something
> | like this (untested):
> | 
> | grep -rl MACHINE_START arch/arm | xargs --no-run-if-empty \
> |   sed -i '/MACHINE_START/,/MACHINE_END/ { /\.(phys_io|io_pg_offst)/d }'
> | 
> | as over time the number of boards, etc, will change, and there's already
> | context changes with these patches caused by the memblock stuff.
> 
> My intention was to have your patch merged - as patches - into an
> appropriate place in my tree, and then just before the merge window
> run that script to remove all the references to phys_io/io_pg_offst,
> and finally, some time later, the members from the structure.

Just to be clear, would you prefer for Jeremy to send you those initial 
patches through your patch system or via a Git pull request?


Nicolas
