From: tony@atomide.com (Tony Lindgren)
Date: Thu, 8 Dec 2011 16:42:01 -0800
Subject: [PATCH v2 1/2] OMAP2+: DMA: Workaround for invalid source
 position
In-Reply-To: <1857964.6c1BL8cmCX@barack>
References: <1320658387-21067-1-git-send-email-peter.ujfalusi@ti.com>
 <4EBBC79E.30701@bitmer.com> <4EBBCB4C.9030202@bitmer.com>
 <1857964.6c1BL8cmCX@barack>
Message-ID: <20111209004201.GI31337@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* P?ter Ujfalusi <peter.ujfalusi@ti.com> [111129 04:26]:
> On Thursday 10 November 2011 15:02:04 Jarkko Nikula wrote:
> > On 11/10/2011 02:46 PM, Jarkko Nikula wrote:
> > > On 11/07/2011 11:33 AM, Peter Ujfalusi wrote:
> > > 
> > > I think this is enough:
> > > 
> > > if (unlikely(p->dma_read(CDAC, lch) == 0))
> > > offset = p->dma_read(CSSA, lch);
> > > 
> > > I suppose offset is ok for normal case as it is already read (twise)
> > > above.
> > Or actually my proposal could have a race if CDAC changes between CSAC
> > read and CDAC read. In that case it's better to re-read CSAC as your
> > patch does after CDAC test and give to both:
> > 
> > Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> 
> Tony, have you taken this patch? I failed to find it in the l-o tree...

Sorry for the delay, applying both into fixes-non-critical.

Tony
