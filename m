From: will.deacon@arm.com (Will Deacon)
Date: Wed, 29 Jun 2011 21:08:20 +0100
Subject: [RFC PATCH v5] ARM hibernation / suspend-to-disk (fwd)
In-Reply-To: <alpine.DEB.2.00.1106291555330.2266@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106131303290.25153@localhost6.localdomain6>
	<20110613122601.GC12325@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106131400090.25153@localhost6.localdomain6>
	<20110613164452.GE13643@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106151349520.11405@localhost6.localdomain6>
	<4E0B3C48.1060101@parrot.com>
	<alpine.DEB.2.00.1106291555330.2266@localhost6.localdomain6>
Message-ID: <20110629200820.GC12421@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Frank,

On Wed, Jun 29, 2011 at 04:14:23PM +0100, Frank Hofmann wrote:
> Have you seen Will Deacon's suggested kexec changes ? That keeps a "reset 
> stack" page around, _elsewhere_, and I've been considering using that. In 
> the end, all swsusp_arch_resume() really requires is a stack page that's 
> guaranteed to be outside the target kernel data, thereby left alone by the 
> restore. __nosavedata is merely one way.

For what it's worth, in v4 of that series (hopefully I'll post it soon)
I'm starting to think about SMP kexec which necessitates that the reserved
stack page is placed in a fixed location. I'm planning to memblock_reserve
the page immediately below swapper for this.

Will
