From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Mon, 28 Sep 2009 23:41:22 +0400
Subject: [PATCH] arm: fix compilation of entry-common.S for older CPUs
In-Reply-To: <20090918162711.GA31263@pengutronix.de>
References: <1253285745-4198-1-git-send-email-mad_soft@inbox.ru>
	<20090918162711.GA31263@pengutronix.de>
Message-ID: <20090928194121.GA12304@rainbow>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18:27 Fri 18 Sep     , Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Fri, Sep 18, 2009 at 06:55:45PM +0400, Dmitry Artamonow wrote:
> > Commit 181f817eaaca4c1f introduced some new code to entry-common.S
> > Sadly, this new code uses 'bx' instruction which is available only on
> > ARMv5 and higher CPUs. This causes following compilation errors when
> > building kernel for StrongARM (ARMv4):
> > 
> > arch/arm/kernel/entry-common.S: Assembler messages:
> > arch/arm/kernel/entry-common.S:129: Error: selected processor does not
> >  support `bx ip'
> > arch/arm/kernel/entry-common.S:138: Error: selected processor does not
> >  support `bx ip'
> > 
> > Fix these errors by using 'mov pc' instead of 'bx'.
> > 
> > Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> I wonder if newer glibc's have the same problem as the code is taken
> more or less from there ...
> 
> Thanks
> Uwe

Russell, are you ok with this fix? Should I submit patch to your patch
tracker?

(It seems that first time around patch didn't get through to you, due to your
server being picky about SMTP servers without matching reverse DNS, so
in case you haven't seen the patch on the list, I'm attaching it here again)

-- 
Best regards,
Dmitry "MAD" Artamonow
