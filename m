From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 11 Oct 2016 11:36:59 +0200
Subject: [PATCH 2/9] drm/sun4i: tcon: Move SoC specific quirks to a DT
 matched data structure
In-Reply-To: <CAGb2v67vZLCtUOaqBwtAnHmCMpoxmh3pxjtD5TL2nWp3Lm-Pzg@mail.gmail.com>
References: <20161006160629.11198-1-wens@csie.org>
 <20161006160629.11198-3-wens@csie.org>
 <20161007083853.GH4684@lukather>
 <CAGb2v67vZLCtUOaqBwtAnHmCMpoxmh3pxjtD5TL2nWp3Lm-Pzg@mail.gmail.com>
Message-ID: <20161011093659.GQ3462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 05:16:21PM +0800, Chen-Yu Tsai wrote:
> On Fri, Oct 7, 2016 at 4:38 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi,
> >
> > On Fri, Oct 07, 2016 at 12:06:22AM +0800, Chen-Yu Tsai wrote:
> >> +struct sun4i_tcon_quirks {
> >> +     bool    is_sun5i;       /* sun5i has undocumented mux */
> >> +     bool    has_channel_1;  /* a33 does not have channel 1 */
> >> +     bool    has_bypass_src; /* has separate input bypassing CEU */
> >> +     bool    has_dma_src;    /* has DMA input */
> >> +};
> >> +
> >
> > I'd really prefer to keep the has_mux quirk name. is_sun5i doesn't
> > really relate to what we're doing there, is redundant with the
> > compatible, and render the other quirks name useless, since we could
> > just have is_sun.i quirks and deal with that (which is essentially
> > what we were doing before).
> 
> Lets call it has_unknown_mux then. has_mux would be confusing with
> the HDMI and MIPI DSI muxes on sun6i.

That works for me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/c35796a0/attachment.sig>
