From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 6 Mar 2013 12:01:59 +0000
Subject: [PATCH 18/23] ASoC: samsung: convert to dmaengine API
In-Reply-To: <CAAgF-Bd=b721r_hiJKGDhw1AqRKC8bNkLh6f9ipcGdFtkM62vQ@mail.gmail.com>
References: <1362505353-8873-1-git-send-email-arnd@arndb.de>
 <1362505353-8873-19-git-send-email-arnd@arndb.de>
 <CAAgF-Bd=b721r_hiJKGDhw1AqRKC8bNkLh6f9ipcGdFtkM62vQ@mail.gmail.com>
Message-ID: <201303061201.59414.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 March 2013, Padma Venkat wrote:

> > +               if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> > +                       config.direction = DMA_MEM_TO_DEV;
> > +                       config.dst_addr = prtd->params->dma_size;
> > +                       config.dst_addr_width = prtd->params->dma_addr;
> 
> dma_addr and dma_size got interchanged.

Ok, fixed.

> Except the above one I tested this patch on 5250. It's working fine.

Thanks a lot for testing this!

	Arnd
