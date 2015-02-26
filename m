From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 26 Feb 2015 09:52:48 +0100
Subject: [PATCH 00/11] drm/rockchip: add support for lvds controller and
 external encoders
In-Reply-To: <1422721984-27782-1-git-send-email-heiko@sntech.de>
References: <1422721984-27782-1-git-send-email-heiko@sntech.de>
Message-ID: <5725053.2iB7qVhEzL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Am Samstag, 31. Januar 2015, 17:32:53 schrieb Heiko Stuebner:
> This series adds support for the lvds encoder present on rk3288 soc and
> allows external connectors to use the generic rgb pins.
> 
> On the older socs (rk3188, rk3066, etc) these pins where accessible by
> anyone, while on the rk3288 the lvds controller controls access to them.
> 
> So while on the old socs an external encoder was explicitly connected
> to one of the two lcd-controllers, on the rk3288 the lvds in between
> can toggle which controller should be the source.
> 
> To facilitate this the lvds encoder can use two modes. When a panel is
> attached it acts as encoder and without panel it just registers a bridge
> that can be used later.
> 
> The bridge association to an encoder is done via a rockchip,rgb-bridge
> property in the encoder node itself and handled in rockchip_drm_load
> to not leak rockchip-specific handling into generic encoder drivers.
> 
> 
> As example on how this can work, I've included a driver for simple
> (dumb) vga encoders, like the adv7123 (and clones) as used on the
> rk3288-firefly board. This same encoder is used on the Rayeager-px2
> board but there connected directly to the rgb pins of the rk3066
> which will hopefully also be supported in the future.
> 
> I've named this currently vga-simply (inspired by panel-simple), because
> so far I have found the adv7123 (and two clones) but I guess there will
> be more dumb vga encoders around that only differ in minimal things.
> 
> 
> Similarly, most of the rk3288-based TV-boxes use a rk1000 i2c tv encoder
> connected in a similar way - and again directly connected on the
> rk3188-radxarock.
> 
> 
> Caveats:
> - the i2c subdirectory is probably not the right one for my vga encoder
>   so if somebody could suggest where this should live, I'd be very happy
> - I'm not sure if I'm abusing some drm-APIs in a wrong way :-)

any comments or suggestions?

Especially on the core drm integration? Am I abusing stuff or does this look 
somewhat sane?


Thanks
Heiko
