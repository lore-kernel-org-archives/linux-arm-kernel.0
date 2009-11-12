From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 12 Nov 2009 08:53:03 +0100
Subject: drivers/mtd/nand/orion_nand.c build failure with old ABI
In-Reply-To: <alpine.LFD.2.00.0911111054500.16711@xanadu.home>
References: <20091111153223.GA3688@deprecation.cyrius.com>
	<alpine.LFD.2.00.0911111054500.16711@xanadu.home>
Message-ID: <20091112085303.213dc75c@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 Nov 2009 10:55:43 -0500 (EST)
Nicolas Pitre <nico@fluxnic.net> wrote:

> On Wed, 11 Nov 2009, Martin Michlmayr wrote:
> 
> > drivers/mtd/nand/orion_nand.c fails to build when EABI is not set:
> > 
> >   CC      drivers/mtd/nand/orion_nand.o
> > /tmp/ccDFyfwN.s: Assembler messages:
> > /tmp/ccDFyfwN.s:120: Error: first destination register must be even -- `ldrd r3,[ip]'
> > make[3]: *** [drivers/mtd/nand/orion_nand.o] Error 1
> > make[2]: *** [drivers/mtd/nand] Error 2
> 
> Grrrrr.  Let me think of a workaround.

Interesting problem. I looked in the GCC manual for a matching
constraint to satisfy this, but didn't find anything that seems to fit
right away. SPARC has the

    `U'      Even register

constraint, and perhaps it would be make good sense to have the same
for ARM. Not that it helps right the current situation, but anyway :-)

// Simon
