From: jernej.skrabec@siol.net (Jernej =?utf-8?B?xaBrcmFiZWM=?=)
Date: Fri, 19 May 2017 20:00:15 +0200
Subject: [linux-sunxi] Re: [RFC PATCH 02/11] drm: sun4i: add support for
 H3 mixers
In-Reply-To: <695DFDD0-1925-433C-AB88-B90EE461C203@aosc.io>
References: <20170517164354.16399-1-icenowy@aosc.io>
 <20170519174729.q5qk2vqlibzx3zrv@flea.home>
 <695DFDD0-1925-433C-AB88-B90EE461C203@aosc.io>
Message-ID: <2675772.KPXzA3y97S@jernej-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

Dne petek, 19. maj 2017 ob 19:49:58 CEST je Icenowy Zheng napisal(a):
> ? 2017?5?20? GMT+08:00 ??1:47:29, Maxime Ripard <maxime.ripard@free-
electrons.com> ??:
> >On Thu, May 18, 2017 at 12:43:45AM +0800, Icenowy Zheng wrote:
> >> From: Icenowy Zheng <icenowy@aosc.xyz>
> >> 
> >> Allwinner H3 SoC has two mixers, one has 1 VI channel and 3 UI
> >
> >channels,
> >
> >> and the other has 1 VI and 1 UI.
> >> 
> >> Add support for these two variants.
> >> 
> >> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> >> ---
> >> 
> >>  drivers/gpu/drm/sun4i/sun8i_mixer.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >> 
> >> diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >
> >b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >
> >> index cb193c5f1686..d658a3a8159a 100644
> >> --- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >> +++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
> >> @@ -390,11 +390,29 @@ static const struct sun8i_mixer_cfg
> >
> >sun8i_v3s_mixer_cfg = {
> >
> >>  	.ui_num = 1,
> >>  
> >>  };
> >> 
> >> +static const struct sun8i_mixer_cfg sun8i_h3_mixer0_cfg = {
> >> +	.vi_num = 1,
> >> +	.ui_num = 3,
> >> +};
> >> +
> >> +static const struct sun8i_mixer_cfg sun8i_h3_mixer1_cfg = {
> >> +	.vi_num = 1,
> >> +	.ui_num = 1,
> >> +};
> >> +
> >> 
> >>  static const struct of_device_id sun8i_mixer_of_table[] = {
> >>  
> >>  	{
> >>  	
> >>  		.compatible = "allwinner,sun8i-v3s-de2-mixer",
> >>  		.data = &sun8i_v3s_mixer_cfg,
> >>  	
> >>  	},
> >> 
> >> +	{
> >> +		.compatible = "allwinner,sun8i-h3-de2-mixer0",
> >> +		.data = &sun8i_h3_mixer0_cfg
> >> +	},
> >> +	{
> >> +		.compatible = "allwinner,sun8i-h3-de2-mixer1",
> >> +		.data = &sun8i_h3_mixer1_cfg
> >> +	},
> >
> >So the only difference between the two is the number of ui planes?
> 
> Not only., but currently we only implemented this.
> 
> More functions differ, but we still don't support them...
> 

As far as I can tell, they only differ in ui & vi number of planes and between 
different SoCs, max plane size.

Icenowy,
Do you know any other property they differ? I think everything else is based 
mostly on ui & vi number of planes.

Best regards,
Jernej

> >Why not create a property to give the number then, instead of a
> >compatible?
> >
> >Maxime
> 
> --
> You received this message because you are subscribed to the Google Groups
> "linux-sunxi" group. To unsubscribe from this group and stop receiving
> emails from it, send an email to linux-sunxi+unsubscribe at googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
