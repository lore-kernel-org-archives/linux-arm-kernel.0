From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Jun 2012 21:04:37 +0000
Subject: [RFC PATCHv1 1/2] ARM: socfpga: initial support for Altera's
 SOCFPGA platform.
In-Reply-To: <20120627204018.0bfef362@skate>
References: <1340805007-3313-1-git-send-email-dinguyen@altera.com>
 <20120627180516.GA17393@elf.ucw.cz> <20120627204018.0bfef362@skate>
Message-ID: <201206302104.37937.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 27 June 2012, Thomas Petazzoni wrote:
> > > > +#define NR_IRQS                  512
> > > 
> > > You should be looking at using SPARSE_IRQ to avoid having a maximum
> > > number of irqs. See for example mach-highbank/.
> > 
> > Is maximum number of interrupts a problem? 512 does not seem
> > excessive.
> 
> Regardless of the value of NR_IRQS, there is apparently a trend to use
> SPARSE_IRQ anyway. However, I am not at the best place to explain why
> SPARSE_IRQ is now considered the right thing to use.

The main reason for me is to get rid of a hardcoded NR_IRQS constant,
whihc is a blocker for multiplatform kernels. New platforms should
do all they can to allow being built together with other platforms
in the same kernel. While we're not there yet, doing sparse irq
is an important step in the right direction and should not be hard
to do for new code.

	Arnd
