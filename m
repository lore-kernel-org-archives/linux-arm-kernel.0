From: boojin.kim@samsung.com (boojin)
Date: Thu, 14 Jul 2011 18:04:26 +0900
Subject: [PATCH 3/7] DMA: PL330: Add DMA capabilities
In-Reply-To: <CABb+yY198iVKYV765C_dokzciL9en3kkRyZgcgYpp5WphPNZmw@mail.gmail.com>
References: <1309781915-31549-1-git-send-email-kgene.kim@samsung.com>
	<1309781915-31549-4-git-send-email-kgene.kim@samsung.com>
	<CAPTzV15Y7JFDKsec8x-M0C1AFLOMp39QvHpRCsO=E001P_tH9A@mail.gmail.com>
	<CABb+yY0M659Ob0u+wOBW5i6v_VfpayRkY29-TUNpsp1oVLn-SQ@mail.gmail.com>
	<002201cc41c0$fdf79810$f9e6c830$%kim@samsung.com>
	<CABb+yY198iVKYV765C_dokzciL9en3kkRyZgcgYpp5WphPNZmw@mail.gmail.com>
Message-ID: <002801cc4205$08c91f90$1a5b5eb0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jassi Brar Wrote:
> On Thu, Jul 14, 2011 at 6:27 AM, boojin <boojin.kim@samsung.com> wrote:
> > Jassi Brar wrote:
> >
> >> On Tue, Jul 5, 2011 at 12:03 PM, Chanho Park <parkch98@gmail.com> wrote:
> >> > Kukjin Kim <kgene.kim <at> samsung.com> writes:
> >> >
> >> > (snip)
> >> >
> >> >> +             if (slave_config->direction == DMA_TO_DEVICE) {
> >> >> +                     if (slave_config->dst_addr)
> >> >> +                             peri->fifo_addr = slave_config->dst_addr;
> >> >> +                     if (slave_config->dst_addr_width) {
> >> >> +                             i = 0;
> >> >> +                             while (slave_config->dst_addr_width != (1
> <<
> >> > i))
> >> >> +                                     i++;
> >> >> +                             peri->burst_sz = i;
> >> >> +                     }
> >> >> +             } else if (slave_config->direction == DMA_FROM_DEVICE)
> {
> >> >> +                     if (slave_config->src_addr)
> >> >> +                             peri->fifo_addr = slave_config->src_addr;
> >> >> +                     if (slave_config->src_addr_width) {
> >> >> +                             i = 0;
> >> >> +                             while (slave_config->src_addr_width != (1
> <<
> >> > i))
> >> >> +                                     i++;
> >> >> +                             peri->burst_sz = i;
> >> >
> >> > Re-send including cc and mailing lists
> >> > --
> >> > pl330 dmac only supports 1/2/4/8/16 bytes burst size.
> >> > If some bad D/D doesn't use powers of 2 width,
> >> > dmaengine is going to infinite loop.
> >> > You'd better check it instead of running loop.
> >> >
> >> It might be even better to start with max possible width and
> >> keep decreasing 'i' in the loop.
> > I will addressed your comment on next release.
> 
> Actually, best would be to simply do
>     peri->burst_sz =  __ffs(slave_config->src_addr_width);
> 
> And sorry I haven't yet reviewed the patches because I have been
> very busy lately. Will be more active in a few days.

Thanks for good information. Please give me your feedback.
I will release next version after gathering and reflecting all comments.
