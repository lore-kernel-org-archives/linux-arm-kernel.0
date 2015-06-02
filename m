From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 2 Jun 2015 11:19:51 +0200
Subject: [PATCH 2/2] dmaengine: hdmac: Implement interleaved transfers
In-Reply-To: <20150601083216.GH25118@odux.rfo.atmel.com>
References: <1432735313-481-1-git-send-email-maxime.ripard@free-electrons.com>
 <1432735313-481-3-git-send-email-maxime.ripard@free-electrons.com>
 <20150601083216.GH25118@odux.rfo.atmel.com>
Message-ID: <20150602091951.GV23777@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 01, 2015 at 10:32:16AM +0200, Ludovic Desroches wrote:
> >  	channel_writel(atchan, CTRLA, 0);
> >  	channel_writel(atchan, CTRLB, 0);
> >  	channel_writel(atchan, DSCR, first->txd.phys);
> > +	channel_writel(atchan, SPIP, ATC_SPIP_HOLE(first->src_hole) |
> > +		       ATC_SPIP_BOUNDARY(first->boundary));
> > +	channel_writel(atchan, DPIP, ATC_DPIP_HOLE(first->dst_hole) |
> > +		       ATC_DPIP_BOUNDARY(first->boundary));
> 
> Can't we get a trivial condition to perform these two writes only if
> needed?

Is that really needed?

My understanding is that the hardware will only take this into account
if we set the ATC_SRC_PIP and ATC_DST_PIP bits anyway, so the check is
already there.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150602/1f1e61c4/attachment.sig>
