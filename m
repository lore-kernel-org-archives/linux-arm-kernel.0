From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 24 Oct 2012 12:09:58 +0000
Subject: [PATCH v3 0/5] zynq subarch cleanups
In-Reply-To: <20121024003218.GA31625@beefymiracle.amer.corp.natinst.com>
References: <20121024003218.GA31625@beefymiracle.amer.corp.natinst.com>
Message-ID: <201210241209.58655.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 24 October 2012, Josh Cartwright wrote:
> Things have been relatively quiet on the Zynq front lately.  This patchset does
> a bit of cleanup of the Zynq subarchitecture.  It was the necessary set of
> things I had to do to get a zynq target booting with the upstream qemu model.
> 
> Patches 1 and 2 move zynq to use the GIC and pl310 L2 cache controller device
> tree mappings respectively.
> 
> Patch 3 removes unused clock infrastructure.  the plan is to rework the
> out-of-tree Xilinx generic clk support into something suitable for merging.
> What's in tree now just isn't used at all, and can be removed.
> 
> Patch 4 and 5 move around the static peripheral mappings into the vmalloc area.

Looks all good to me now.

> 
> I intentionally did not Cc stable on patch 5, even though you had
> suggested otherwise.  I do not think it will apply cleanly to the stable
> trees independent of the other patches.  Additionally, with the current
> state of zynq upstream, I'm not convinced there would be enough users to
> make it worth the effort.

Ok, fair enough.

> Additionally, I've left the SCU static mapping around, even though its
> currently unused.  We'll eventually need it around (maybe in a different form)
> when SMP support is added.

Right.

John, are you going to pick up these patches and send a pull request?

	Arnd
