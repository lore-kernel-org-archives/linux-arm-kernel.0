From: jkrzyszt@tis.icnet.pl (Janusz Krzysztofik)
Date: Sat, 24 Oct 2009 01:11:07 +0200
Subject: [PATCH 05/10] omap1: Fix DSP public peripherals support for
	ams-delta
In-Reply-To: <20091023191939.GJ16230@atomide.com>
References: <20091022221013.27408.443.stgit@localhost>
	<4AE0E938.7080305@ti.com> <20091023191939.GJ16230@atomide.com>
Message-ID: <200910240111.10604.jkrzyszt@tis.icnet.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Friday 23 October 2009 21:19:40 Tony Lindgren napisa?(a):
> * Jon Hunter <jon-hunter@ti.com> [091022 16:22]:
> >
> > Tony Lindgren wrote:
> >> From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
> >>
> >> DSP public peripherals used to work on OMAP1510 based (or all OMAP1 class?)
> >> machines as long as old dspgateway code were present in the l-o tree. For
> >> several months it is no longer included, breaking support for McBSP1 based
> >> audio on Amstrad Delta, for example.
> >>
> >> This patch, derived from the old dspgateway code, corrects the problem for the
> >> board by simply taking the DSP out of reset state, I guess. That way, things
> >> should not break when a new dsp code is added to the tree, and the change can
> >> be reverted then.
> >
> > A minor comment/correction here. Although this bit is called "DSP_RST"  
> > this does not actually release the DSP from reset. This bit actually  
> > releases the reset for the "priority registers (TIPB module), EMIF  
> > configuration registers, and the MPUI control logic (partially) in the  
> > DSP", thus allowing you to access the DSP peripherals via the MPUI. Bit  
> > 1 of the same register, called "DSP_EN", actually releases the DSP reset.
> 
> Thanks for clarifying that.

Forgive me my ignorance: do you think that there is still an option of putting any related piece of hardware in an idle state, as you, Tony, has suggested before for the DSP itslef?

Thanks,
Janusz
