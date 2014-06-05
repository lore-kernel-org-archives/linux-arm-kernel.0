From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Wed, 04 Jun 2014 17:17:53 -0700 (PDT)
Subject: [PATCH v2 5/7] ARM: shmobile: r8a7791 dtsi: Add SYS-DMAC0 and
 SYS-DMAC1 nodes
In-Reply-To: <2440127.sDc7m91LPu@avalon>
References: <1401716531-29794-1-git-send-email-geert+renesas@glider.be>
 <1401716531-29794-6-git-send-email-geert+renesas@glider.be>
 <2440127.sDc7m91LPu@avalon>
Message-ID: <871tv4jjkh.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent

> > Add nodes for the SYS-DMA controllers, SYS-DMAC0 and SYS-DMAC1. These
> > both share the same device sources, so are wrapped in the shdma-mux
> > node to allow both to be used.
> > 
> > Cfr. the r8a7790 version by Ben Dooks.
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
(snip)
> > +		sysdma0: dma-controller at e6700020 {
> > +			compatible = "renesas,shdma-r8a7791";
> > +			reg = <0 0xe6700020 0 0xffc0>;
> 
> Even though the registered defined in the datasheet start at 0xe6700020, the 
> documentation clearly states that "The base address of registers for the 
> lower-numbered channels  (0 to 14) is H'E670 0000". I'm also wondering where 
> the size comes from, if you want to span the 0xe6700000 to 0xe670ffff range, 
> the size should be 0xffe0, not 0xffc0.

Unfortunately, this mapping (form 0x20) is required from driver
for historical reasons.
So, driver setting needs to care about it.
Please check DMA_CHANNEL macro for each setup-xxx.c
# but, it works without care about it (?)
# becase there are mirror register there (?), I'm not sure detail


Best regards
---
Kuninori Morimoto
