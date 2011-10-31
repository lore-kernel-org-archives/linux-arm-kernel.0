From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 31 Oct 2011 22:15:13 +0000
Subject: [PATCH 01/51] ARM: reset: introduce arm_arch_reset function
	pointer
In-Reply-To: <20111031143744.GE29349@mudshark.cambridge.arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
	<1319813059-8914-2-git-send-email-will.deacon@arm.com>
	<20111029102108.GY19187@n2100.arm.linux.org.uk>
	<20111029135653.GA25057@mudshark.cambridge.arm.com>
	<20111031141322.GK19187@n2100.arm.linux.org.uk>
	<20111031143744.GE29349@mudshark.cambridge.arm.com>
Message-ID: <20111031221513.GB10576@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 31, 2011 at 02:37:45PM +0000, Will Deacon wrote:
> On Mon, Oct 31, 2011 at 02:13:22PM +0000, Russell King - ARM Linux wrote:
> > On Sat, Oct 29, 2011 at 02:56:53PM +0100, Will Deacon wrote:
> > > The only downside is that I have to go over all of the platforms again
> > > unless I can polish up my Coccinelle-fu. Ho-hum.
> > 
> > Well, I've just given coccinelle a go, and having read all the hype about
> > it, I'm completely disappointed with it to the extent that I'm going to
> > uninstall the tool from my system (unless someone can point out what I'm
> > doing wrong.)
> 
> I'm really new to it, so I'm by no means an expert...

I've spent the rest of today trying to get it to do another trivial task -
adding setup_reboot(mode) to the start of the arch_reset() functions, and
failed to get it to place the call after local variable declarations.
I really don't like the way I seem to have to create a rule for each
possible perturbation of arch_reset (as a function pointer, as a
function, with local variables, without local variables.)

So far, my experiments with it have just resulted in frustration with
virtually zero productivity (just one commit to be precise).
