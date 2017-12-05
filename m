From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 5 Dec 2017 20:23:45 +0100
Subject: [PATCH v2 00/27] Improve DE2 support
In-Reply-To: <23633465.uxSxGdCvtg@jernej-laptop>
References: <20171201060550.10392-1-jernej.skrabec@siol.net>
 <20171205103618.ps64m57xemsbo44r@flea.lan>
 <23633465.uxSxGdCvtg@jernej-laptop>
Message-ID: <20171205192345.vjkyunobrbzjjiv3@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Dec 05, 2017 at 04:52:57PM +0100, Jernej ?krabec wrote:
> Dne torek, 05. december 2017 ob 11:36:18 CET je Maxime Ripard napisal(a):
> > Hi,
> > 
> > On Fri, Dec 01, 2017 at 07:05:23AM +0100, Jernej Skrabec wrote:
> > > Current DE2 driver is very basic and uses a lot of magic constants since
> > > there is no documentation and knowledge about it was limited at the time.
> > > 
> > > With studying BSP source code, deeper knowledge was gained which allows
> > > to improve mainline driver considerably.
> > > 
> > > At the beginning of this series, some code refactoring is done as well
> > > as adding some checks (patches 1-15).
> > > 
> > > Further patches add multi-plane support with HW scaling and all possible
> > > RGB formats (patches 16-21).
> > > 
> > > At last, support for YUV formats is added (patches 22-26).
> > > 
> > > At the end, I included patch which puts lowest plane before second lowest.
> > > This should help testing VI planes when mixer has configuration 1 VI plane
> > > and 1 or more UI planes (most SoCs except V3s).
> > > 
> > > This code was developed on H3, but it should work on every SoC if correct
> > > configuration structure is provided.
> > > 
> > > H3 code can be found here:
> > > https://github.com/jernejsk/linux-1/commits/de2_impr_for_next
> > 
> > Thanks a lot for that huge rework.
> > 
> > I've applied the patches 1 to 26, and will push them to drm-misc once
> > the compilations are done.
> > 
> > In the future, if you happen to do such a huge rework again (which
> > hopefully won't be needed :)), please use the -M option of
> > format-patch. It will reduce a lot the verbosity of files renaming and
> > will help the review.
> 
> Noted.

It turned out that there was also a change queued for drm-misc that
was renaming (and changing the prototype of)
drm_plane_helper_check_state into
drm_atomic_helper_check_plane_state. I fixed that up in tree, and
tested on the A83t, but you probably want to double check.

> I think I missed initialization of min_scaler and max_scaler in 
> sun8i_vi_layer_atomic_check() in sun8i_vi_layer.c when I was reworking 
> patches.
> 
> Will you fix patch with those two lines
> min_scale = DRM_PLANE_HELPER_NO_SCALING;
> max_scale = DRM_PLANE_HELPER_NO_SCALING;
> 
> or should I send new patch which fixes that or should I send new version of 
> original patch?

We don't rebase in drm-misc, so please send an additional patch.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171205/40b15ffc/attachment.sig>
