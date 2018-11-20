From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 20 Nov 2018 14:23:57 +0100
Subject: [PATCH v2 01/12] drm/sun4i: sun6i_mipi_dsi: Compute burst mode
 loop N1 instruction delay
In-Reply-To: <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
References: <20181116163916.29621-1-jagan@amarulasolutions.com>
 <20181116163916.29621-2-jagan@amarulasolutions.com>
 <20181119082707.kbsw2gyntxxbh6no@flea>
 <CAMty3ZBDa2wjjCh8NtrbKNYz=mr1xhZKv9JfnmDPDBQRO+CkYw@mail.gmail.com>
Message-ID: <20181120132357.xge6gkurjjjvwi2i@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 19, 2018 at 04:28:29PM +0530, Jagan Teki wrote:
> On Mon, Nov 19, 2018 at 1:57 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> >
> > On Fri, Nov 16, 2018 at 10:09:05PM +0530, Jagan Teki wrote:
> > > Loop N1 instruction delay for burst mode lcd panel are
> > > computed as per BSP code.
> > >
> > > Reference code is available in BSP (from linux-sunxi
> > > drivers/video/sunxi/disp2/disp/de/lowlevel_sun50iw1/de_dsi.c)
> > >
> > > dsi_dev[sel]->dsi_inst_loop_num.bits.loop_n1=
> > > (panel->lcd_ht-panel->lcd_x)*(150)/(panel->lcd_dclk_freq*8) - 50;
> > > => (((mode->htotal - mode->hdisplay) * 150) /
> > >      ((mode->clock / 1000) * 8)) - 50;
> > >
> > > So use the similar computation for loop N1 delay.
> > >
> > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> >
> > *why* are you doing this? What is it fixing? on which devices?
> 
> You mentioned the separate function to compute the delay for all modes
> [1], ie what I did. did I missing anything?

You're missing that you are never explaining why that patch is needed
in the first place. Or answering the question I asked a couple of
lines above.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181120/eca9226d/attachment-0001.sig>
