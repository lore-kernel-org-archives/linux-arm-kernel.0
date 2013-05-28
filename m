From: horms@verge.net.au (Simon Horman)
Date: Tue, 28 May 2013 14:29:00 +0900
Subject: [PATCH 09/12] ARM: shmobile: r8a7740: Add Suspend-To-RAM A3SM
In-Reply-To: <20130528035019.GI13532@quad.lixom.net>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au>
 <1369645193-3595-10-git-send-email-horms+renesas@verge.net.au>
 <20130528035019.GI13532@quad.lixom.net>
Message-ID: <20130528052900.GB25005@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 27, 2013 at 08:50:19PM -0700, Olof Johansson wrote:
> Hi,
> 
> On Mon, May 27, 2013 at 05:59:50PM +0900, Simon Horman wrote:
> > From: Bastian Hecht <hechtb@gmail.com>
> > 
> > We add 2 Suspend to RAM modes:
> > - A3SM PLL0 on/off:     Power domain A3SM that contains the ARM core
> >                         and the 2nd level cache with either PLL0 on
> >                         or off
> > 
> > As the suspend to memory mechanism we use A3SM PLL off. A3SM PLL on
> > is included here too, so CPUIdle can use both power down modes (not
> > included in this patch).
> > 
> > The setup of the SYSC regarding the external IRQs is taken from
> > pm-sh7372.c from Magnus Damm.
> > 
> > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
> 
> Missing S-o-b from you, Simon?

Oops sorry about that.

> > +	.text
> > +ENTRY(v7_cpu_resume)
> > +	bl	v7_invalidate_l1
> > +	b	cpu_resume
> > +ENDPROC(v7_cpu_resume)
> 
> This is a global namespace so it'll conflict with i.MX whenever
> you multiplatform enable shmobile. Might want to pick a more
> unique name.

Bastian, could you suggest an alternate name?
