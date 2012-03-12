From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Mar 2012 21:15:54 +0000
Subject: [PATCH 3/4] ARM: create a common IOMEM definition
In-Reply-To: <4F5E4178.50801@gmail.com>
References: <1331500100-31351-1-git-send-email-robherring2@gmail.com>
 <201203112134.45302.arnd@arndb.de> <4F5E4178.50801@gmail.com>
Message-ID: <201203122115.54422.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 March 2012, Rob Herring wrote:
> On 03/11/2012 04:34 PM, Arnd Bergmann wrote:
> > On Sunday 11 March 2012, Rob Herring wrote:
> >> From: Rob Herring <rob.herring@calxeda.com>
> >>
> >> Several platforms create IOMEM defines for casting to 'void __iomem *',
> >> and other platforms are incorrectly using __io() macro for the same
> >> purpose. This creates a common definition and removes all the platform
> >> specific versions. Rather than try to make linux/io.h and asm/io.h
> >> assembly safe, the assembly version of IOMEM is moved into
> >> asm/assembler.h.
> > 
> > Looks good to me, in order to fix the problem at hand. I'm not sure
> > about spreading the IOMEM() macro further, that is largely a separate
> > problem and only a question of style, not of correctness as with __io().
> 
> Got a better suggestion? I didn't think adding IOMEM to 5 more platforms
> or inventing something different was the right path. Hopefully this is a
> shrinking problem as things move to DT.

In a cleanup series I started earlier, I used ${PLATFORM}_IO_P2V, which
is now used on at91 and imx. I'm not particularly attached to that
one either, the basic idea was that we could define them all concurrently,
but in hindsight that looks flawed now. Let's just use the patch you came
up with.

	Arnd
