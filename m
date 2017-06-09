From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 9 Jun 2017 16:48:25 +0200
Subject: [PATCH v2 04/11] drm: sun4i: add support for H3's TCON0/1
In-Reply-To: <4CD8A3BB-965C-4C74-884C-ACE8AAF9989B@aosc.io>
References: <20170604160149.30230-1-icenowy@aosc.io>
 <20170604160149.30230-5-icenowy@aosc.io>
 <3642057.oKT9kIlu8M@jernej-laptop>
 <493AC6F2-3CB3-48F5-9568-A34AA927238F@aosc.io>
 <20170607094343.qqiwnu2mhmoi6jn7@flea.lan>
 <52F9F9C7-9A9C-435D-A0AF-FDD4317DAD69@aosc.io>
 <20170607141957.akonr7hmuwpt7hlt@flea.lan>
 <4CD8A3BB-965C-4C74-884C-ACE8AAF9989B@aosc.io>
Message-ID: <20170609144825.jdalt2xakhcenhk5@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 07, 2017 at 10:21:02PM +0800, Icenowy Zheng wrote:
> 
> 
> ? 2017?6?7? GMT+08:00 ??10:19:57, Maxime Ripard <maxime.ripard@free-electrons.com> ??:
> >On Wed, Jun 07, 2017 at 05:44:56PM +0800, Icenowy Zheng wrote:
> >> ? 2017?6?7? GMT+08:00 ??5:43:43, Maxime Ripard
> ><maxime.ripard@free-electrons.com> ??:
> >> >On Mon, Jun 05, 2017 at 03:03:47AM +0800, Icenowy Zheng wrote:
> >> >> >You should also expand function sun4i_drv_node_is_tcon() at
> >> >sun4i_drv.c
> >> >> >with 
> >> >> >new entries, but I'm not sure if this fits in this patch.
> >> >> 
> >> >> Instead I think it should be renamed to something like
> >> >> "sun4i_drv_node_is_tcon_with_ch0".
> >> >
> >> >I'm not sure, or at least, it shouldn't make any difference, since
> >> >TCON without a channel 0 will not have an endpoint 0, so this will
> >be
> >> >dealt with already.
> >> 
> >> But that will prevent new coders from add CH1-less TCON
> >> compatibles to this function.
> >
> >Why? We already have such TCONs (like the A33's, or V3S') in that
> >function.
> 
> Sorry, CH0-less.

That's not really an issue I think, since the endpoint 0 will not be
there on those TCONs, the code will bail out.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170609/31fd9761/attachment.sig>
