From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 28 Nov 2011 10:53:04 +0000
Subject: [PATCH v2 1/4] ARM: vexpress: Get rid of MMIO_P2V
In-Reply-To: <20111128104416.GD9581@n2100.arm.linux.org.uk>
References: <1322060508-11298-1-git-send-email-pawel.moll@arm.com>
 <1322060508-11298-2-git-send-email-pawel.moll@arm.com>
 <20111125161500.GD2098@localhost.localdomain>
 <20111128104416.GD9581@n2100.arm.linux.org.uk>
Message-ID: <20111128105247.GA2465@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 28, 2011 at 10:44:16AM +0000, Russell King - ARM Linux wrote:
> On Fri, Nov 25, 2011 at 04:15:00PM +0000, Dave Martin wrote:
> > diff --git a/arch/arm/plat-versatile/headsmp.S b/arch/arm/plat-versatile/headsmp.S
> > index d397a1f..0be2efc 100644
> > --- a/arch/arm/plat-versatile/headsmp.S
> > +++ b/arch/arm/plat-versatile/headsmp.S
> > @@ -28,6 +28,7 @@ ENTRY(versatile_secondary_startup)
> >  pen:	ldr	r7, [r6]
> >  	cmp	r7, r0
> >  	bne	pen
> > +ENDPROC(versatile_secondary_startup)
> 
> This is wrong.  You're telling the assembler that this function ends here.
> It doesn't, it continues on.  Put the ENDPROC at the end of the function.

Dunno what I was thinking of there -- agreed, the ENDPROC() should move
to the end of the file.

(I'm assuming that literals should be included in the size of the
relevant function symbol here -- that's the convention the compiler
follows.)

Cheers
---Dave
