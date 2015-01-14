From: peda@axentia.se (Peter Rosin)
Date: Wed, 14 Jan 2015 21:33:21 +0000
Subject: [PATCH RESEND] pm: at91: Workaround DDRSDRC self-refresh bug
 with LPDDR1 memories
In-Reply-To: <54B69DAB.8010303@atmel.com>
References: <1421241632-2991-1-git-send-email-peda@lysator.liu.se>
 <54B69DAB.8010303@atmel.com>
Message-ID: <018060d2585f4e5480b1bdd39a56e70c@EMAIL.axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nicolas Ferre wrote:
> Le 14/01/2015 14:20, Peter Rosin a ?crit :
> > From: Peter Rosin <peda@axentia.se>
> >
> > The DDRSDR controller (on the ATSAMA5D31) fails miserably to put
> > LPDDR1 memories in self-refresh. Force the controller to think it has
> > DDR2 memories during the self-refresh period, as the DDR2 self-refresh
> > spec is equivalent to LPDDR1, and is correctly implemented in the
> controller.
> >
> > Assume that the second controller has the same fault, and that other
> > CPUs in the family has the same problem, but that is untested.
> >
> > Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> I've just verified your code and the scope of this issue and your
> implementation makes perfect sense.
> 
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> Peter,
> Thanks for your patch. You will probably see it appearing in 3.20 or 3.21.

Great!

> Wenyou,
> Can you please integrate the patch from Peter in your current rework of the
> PM routines (keeping his authorship of course)?
> Please tell me if I can help with this.

To be 100% honest with credits, I should perhaps have mentioned that I
received an unconditional proof-of-concept patch from Atmel support
(Case 00007347). I'm not certain who wrote that patch, but the only thing
that has survived is the idea to temporarily use DDR2 mode and the trivial
change of the register field width in the header file. So, I do not feel too
dishonest by claiming authorship...

Cheers,
Peter
