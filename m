From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Jul 2012 18:55:37 +0000
Subject: [PATCH V3 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <500EC7A5.6020907@wwwdotorg.org>
References: <1335820679-28721-1-git-send-email-jon-hunter@ti.com>
 <201207240719.03601.arnd@arndb.de> <500EC7A5.6020907@wwwdotorg.org>
Message-ID: <201207241855.37568.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 July 2012, Stephen Warren wrote:
> It seems that given there are two values for dma-names, there really are
> two channels; it's just that one channel is bi-directional, and the
> second has two alternatives.
> 
> Still, I guess you could also view this as three separate channels
> instead. In which case, the text below makes sense.
> 
> > 3. A device with three channels, one of which has two alternatives:
> > 
> >         dmas = <&dma0 1 4   /* first channel,  data read */
> >                 &dma0 2 6   /* second channel, data write */
> >                 &dma1 1 0   /* third channel,  error read */
> >                 &dma2 1 0>; /* third channel,  ernative error read */
> >         dma-names = "data", "data", "error", "error";
> > 

A bidirectional channel would have only one request line, not two,
and we would write that as

	dmas = <&dma0 3 4>; /* one channel on dmarq 4, read-write */


	Arnd
