From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Oct 2017 16:38:06 +0200
Subject: [PATCH 05/23] drm/sun4i: tcon: Don't rely on encoders to enable
 the TCON
In-Reply-To: <CAGb2v66AAVv+mMcEyiF36OteyYxr82kt78XXR5p0HkymJFF3Tw@mail.gmail.com>
References: <cover.fe3d65d1ee05a55224d26e7d113388c428592b26.1508231063.git-series.maxime.ripard@free-electrons.com>
 <90b4396e19b3eca61b2ebfdae0672074b88ad74d.1508231063.git-series.maxime.ripard@free-electrons.com>
 <CAGb2v66AAVv+mMcEyiF36OteyYxr82kt78XXR5p0HkymJFF3Tw@mail.gmail.com>
Message-ID: <20171017143806.yrloimhpzioo7sk6@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 17, 2017 at 05:28:42PM +0800, Chen-Yu Tsai wrote:
> On Tue, Oct 17, 2017 at 5:06 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > So far, we've required all the TCON-connected encoders to call the TCON
> > enable and disable functions.
> >
> > This was made this way because in the RGB/LVDS case, the TCON is the CRTC
> > and the encoder. However, in all the other cases (HDMI, TV, DSI, etc.), we
> > have another encoder down the road that needs to be programmed.
> >
> > We also needed to know which channel the encoder is connected to, which is
> > encoder-specific.
> >
> > The CRTC's enable and disable callbacks can work just fine for our use
> > case, and we can get the channel to use just by looking at the type of
> > encoder, since that is fixed. Implement those callbacks, which will
> > remove some of the encoder boilerplate.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Reviewed-by: Chen-Yu Tsai <wens@csie.org>

Applied, thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171017/56d9f846/attachment.sig>
