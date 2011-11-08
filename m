From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 08 Nov 2011 15:22:59 -0500 (EST)
Subject: [PATCHv3 2/2] msm: Support DEBUG_LL on MSM8660 and MSM8960
In-Reply-To: <20111108195956.GA13998@huya.qualcomm.com>
References: <1320777184-22446-1-git-send-email-sboyd@codeaurora.org>
 <1320777184-22446-3-git-send-email-sboyd@codeaurora.org>
 <alpine.LFD.2.02.1111081406220.3307@xanadu.home>
 <4EB97F83.3070509@codeaurora.org> <20111108195956.GA13998@huya.qualcomm.com>
Message-ID: <alpine.LFD.2.02.1111081521110.3307@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 8 Nov 2011, David Brown wrote:

> On Tue, Nov 08, 2011 at 11:14:11AM -0800, Stephen Boyd wrote:
> > On 11/08/11 11:08, Nicolas Pitre wrote:
> > > Independently from this patch, I was wondering about this code:
> > >
> > >> +	.macro	senduart, rd, rx
> > >> +#ifdef CONFIG_MSM_HAS_DEBUG_UART_HS
> > >> +	@ Write the 1 character to UARTDM_TF
> > >> +	str	\rd, [\rx, #0x70]
> > >> +#else
> > >>  	teq	\rx, #0
> > >>  	strne	\rd, [\rx, #0x0C]
> > >> +#endif
> > >>  	.endm
> > > Why testing for zero in the #else part?  The upper level code should 
> > > never call this macro with a null byte.
> > 
> > I was wondering the same thing, I don't know why that test for null is
> > there. I will dust off the old 7201a (literally) and see what I can find
> > out. It certainly looks unnecessary.
> 
> Perhaps this is a better fix?  Google removed the 7201a code from
> their tree quite a while back.  I don't have any more working hardware
> to test things with.
> 
> David
> 
> >From b4a76f1561d35d043f9266f8fe47725389ea7ba9 Mon Sep 17 00:00:00 2001
> From: David Brown <davidb@codeaurora.org>
> Date: Tue, 8 Nov 2011 11:44:05 -0800
> Subject: [PATCH] ARM: msm: Mark 720x targets as broken
> 
> The 720x code is bitrotting.  These have only been compile tested for
> quite some time.  Mark as broken now so they can be removed after a
> while.
> 
> Signed-off-by: David Brown <davidb@codeaurora.org>

I certainly have no problem with that.  Keeping unused code in the tree 
just increases maintenance costs for no gain.


Nicolas
