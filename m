From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 10 Nov 2010 16:30:53 -0700 (MST)
Subject: [PATCH v5 2/3] OMAP3: DMA: Errata i541: sDMA FIFO draining does
	not finish
In-Reply-To: <4CDAA3AA.7070003@nokia.com>
References: <1286261141-1039-1-git-send-email-peter.ujfalusi@nokia.com>
	<1286261141-1039-3-git-send-email-peter.ujfalusi@nokia.com>
	<4CDAA3AA.7070003@nokia.com>
Message-ID: <alpine.DEB.2.00.1011101628410.28301@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Adrian,

On Wed, 10 Nov 2010, Adrian Hunter wrote:

> On 05/10/10 09:45, Peter Ujfalusi wrote:
> 
> > +	if (cpu_is_omap34xx()&&  (l&  OMAP_DMA_CCR_SEL_SRC_DST_SYNC)) {
> > +		int i = 0;
> > +		u32 sys_cf;
> > +
> > +		/* Configure No-Standby */
> > +		l = dma_read(OCP_SYSCONFIG);
> > +		sys_cf = l;
> > +		l&= ~DMA_SYSCONFIG_MIDLEMODE_MASK;
> > +		l |= DMA_SYSCONFIG_MIDLEMODE(DMA_IDLEMODE_NO_IDLE);
> > +		dma_write(l , OCP_SYSCONFIG);
> 
> Are accesses of OCP_SYSCONFIG synchronised?

Do you mean, with respect to later reads and writes from the SDMA device?  
If so, then yes, later reads and writes to the SDMA are guaranteed to 
complete in order.  But perhaps I am misunderstanding what you mean?


- Paul
