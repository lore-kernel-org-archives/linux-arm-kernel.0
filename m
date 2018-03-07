From: stschake@gmail.com (Stefan Schake)
Date: Wed, 7 Mar 2018 03:28:53 +0100
Subject: [PATCH v3 1/8] drm/blend: Add a generic alpha property
In-Reply-To: <20180221130435.yqkpjk4i6qeq3eud@flea.lan>
References: <cover.5d87bf4ea23323f77697cd002dd9e210a27d6062.1518802627.git-series.maxime.ripard@bootlin.com>
 <9403570d73b6eb63ab87488d5e8eb767ba6f1ac7.1518802627.git-series.maxime.ripard@bootlin.com>
 <20180216182041.GU5453@intel.com>
 <CAOZHkRw=eNmkKwpFc=tRaO=TjpNPzcfncCCUneaDb0aBaaONQw@mail.gmail.com>
 <20180221130435.yqkpjk4i6qeq3eud@flea.lan>
Message-ID: <CAOZHkRzF19kQdzf3g4anceVCdZ=ANQg7WxFoDODsGNWWRTsnQQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey,

On Wed, Feb 21, 2018 at 2:04 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
>
> What is the behaviour of the tegra engine when it has both a
> pixel-alpha and a plane-alpha?
>
> Atmel at least will drop one (but I'm not sure which one anymore).

Sorry, I have no more on the Tegra beyond that commit. But I did have some
more play time with drm_hwcomposer and from the rendering, it certainly
expects both to apply at the same time. To further complicate it, from
what I can tell with the VC4 HVS, you can actually configure it to
1) use only pixel alpha 2) use only plane alpha or 3) mix both pixel
and plane alpha, with 3 being what drm_hwc seems to want.

I think once writeback lands it would be a good idea to have some tests
that establish DRM plane blending standards beyond text in docs :)

Regards,
Stefan
