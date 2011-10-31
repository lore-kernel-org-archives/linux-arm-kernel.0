From: will.deacon@arm.com (Will Deacon)
Date: Mon, 31 Oct 2011 13:53:14 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031120603.GJ19187@n2100.arm.linux.org.uk>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031120603.GJ19187@n2100.arm.linux.org.uk>
Message-ID: <20111031135314.GD29349@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 12:06:03PM +0000, Russell King - ARM Linux wrote:
> On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> > Hi Russell,
> > 
> > On Sat, Oct 29, 2011 at 11:21:08AM +0100, Russell King - ARM Linux wrote:
> > > This would then allow everyone to hook into the restart via the same
> > > method irrespective of what they want, and if they want the old
> > > 'arch_reset' way, call setup_restart() themselves.
> > 
> > Yup, it's a fantastic idea because it allows us to put all of the identity
> > mapping bits into setup_restart as well. So then platforms make the choice
> > about the mapping they want, rather than being told via the reboot mode.
> 
> I've now committed my patch, so if you'd like to give it an acked by,
> and preferably a tested-by, I'll publish it out in a stable branch.

I gave it a spin on my Versatile Express and it reboots as expected.

Acked-and-tested-by: Will Deacon <will.deacon@arm.com>

Will
