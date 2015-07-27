From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 27 Jul 2015 08:48:04 +0200
Subject: [PATCH v2 1/2] dmaengine: Add an enum for the dmaengine
 alignment constraints
In-Reply-To: <20150720110325.502af335@free-electrons.com>
References: <1437381693-18948-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150720110325.502af335@free-electrons.com>
Message-ID: <20150727064804.GN2564@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 20, 2015 at 11:03:25AM +0200, Thomas Petazzoni wrote:
> Maxime,
> 
> On Mon, 20 Jul 2015 10:41:32 +0200, Maxime Ripard wrote:
> 
> >  /**
> > + * enum dmaengine_alignment - defines alignment of the DMA async tx
> > + * buffers
> > + */
> > +enum dmaengine_alignment {
> > +	DMAENGINE_ALIGN_1_BYTE = 0,
> > +	DMAENGINE_ALIGN_2_BYTES = 1,
> > +	DMAENGINE_ALIGN_4_BYTES = 2,
> > +	DMAENGINE_ALIGN_8_BYTES = 3,
> > +	DMAENGINE_ALIGN_16_BYTES = 4,
> > +	DMAENGINE_ALIGN_32_BYTES = 5,
> > +	DMAENGINE_ALIGN_64_BYTES = 6,
> > +};
> 
> Sorry I didn't think about this during the first iteration, but this
> define is just the log2 of the values, no? So maybe you could simply do
> something like:
> 
> static inline unsigned int dmaengine_alignment(size_t bytes)
> {
> 	return ilog2(bytes);
> }

I could, but all the rest of the other similar case so far in
dmaengine are made through enum, so I guess it's still better for
consistency. And we also provide a comprehensive list of the valid
values this way, something a function would not provide (or at least
not at compilation time)

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150727/399ba21f/attachment.sig>
