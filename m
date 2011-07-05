From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 05 Jul 2011 16:10:21 +0900
Subject: [PATCH 3/7] DMA: PL330: Add DMA capabilities
In-Reply-To: <CAPTzV15Y7JFDKsec8x-M0C1AFLOMp39QvHpRCsO=E001P_tH9A@mail.gmail.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
	<CAPTzV15Y7JFDKsec8x-M0C1AFLOMp39QvHpRCsO=E001P_tH9A@mail.gmail.com>
Message-ID: <00be01cc3ae2$9d3b7080$d7b25180$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Chanho Park wrote:
> 
> Kukjin Kim <kgene.kim <at> samsung.com> writes:
> 
> (snip)
> 
> > +             if (slave_config->direction == DMA_TO_DEVICE) {
> > +                     if (slave_config->dst_addr)
> > +                             peri->fifo_addr = slave_config->dst_addr;
> > +                     if (slave_config->dst_addr_width) {
> > +                             i = 0;
> > +                             while (slave_config->dst_addr_width != (1
<<
> i))
> > +                                     i++;
> > +                             peri->burst_sz = i;
> > +                     }
> > +             } else if (slave_config->direction == DMA_FROM_DEVICE) {
> > +                     if (slave_config->src_addr)
> > +                             peri->fifo_addr = slave_config->src_addr;
> > +                     if (slave_config->src_addr_width) {
> > +                             i = 0;
> > +                             while (slave_config->src_addr_width != (1
<<
> i))
> > +                                     i++;
> > +                             peri->burst_sz = i;
> 
> Re-send including cc and mailing lists
> --
> pl330 dmac only supports 1/2/4/8/16 bytes burst size.
> If some bad D/D doesn't use powers of 2 width,
> dmaengine is going to infinite loop.
> You'd better check it instead of running loop.

Basically, src_addr_width is defined as a 'enum dma_slave_buswidth' so I
think we don't need to consider it.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
