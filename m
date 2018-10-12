From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 12 Oct 2018 18:03:42 +0800
Subject: [PATCH v3 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if NULL
In-Reply-To: <20181008092111.qcufr4o7cy3nnj4b@flea>
References: <20181004195605.txvbkshvxklyzxyb@flea>
 <20181005215951.99003-1-giulio.benetti@micronovasrl.com>
 <20181005215951.99003-2-giulio.benetti@micronovasrl.com>
 <20181008092111.qcufr4o7cy3nnj4b@flea>
Message-ID: <CAGb2v66FVixU-Ax=KkH5J-ivQ146RUK2DWDwBqDRYqHtpOod9w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 8, 2018 at 5:21 PM Maxime Ripard <maxime.ripard@bootlin.com> wrote:
>
> On Fri, Oct 05, 2018 at 11:59:51PM +0200, Giulio Benetti wrote:
> > If tcon->panel pointer is NULL, trying to dereference from it
> > (i.e. tcon->panel->connector) will cause a null pointer dereference.
> >
> > Add tcon->panel null pointer check before calling
> > sun4i_tcon0_mode_set_dithering().
> >
> > Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> > Fixes: f11adcecbd5f ("drm/sun4i: tcon: Add dithering support for
> >                       RGB565/RGB666 LCD panels")
> > Reviewed-by: Chen-Yu Tsai <wens@csie.org>
>
> Applied both, thanks!

I think this one could have been applied to drm-misc-next-fixes,
as the bug was only recently introduced.

We'll have to make sure it gets backported somehow.

ChenYu
