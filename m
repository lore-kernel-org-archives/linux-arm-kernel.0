From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 28 Sep 2018 13:14:03 +0200
Subject: [PATCH v5 0/6] drm/rockchip: hdmi support for rk3328
In-Reply-To: <20180912124740.20343-1-heiko@sntech.de>
References: <20180912124740.20343-1-heiko@sntech.de>
Message-ID: <1747873.4pnCHigBGG@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 12. September 2018, 14:47:34 CEST schrieb Heiko Stuebner:
> The rk3228/rk3229 and rk3328 socs started using a new type of hdmi-phy
> from Innosilicon that resides completely separate from the dw-hdmi block
> and gets accessed via mmio.
> 
> Additionally the rk3328 dw-hdmi does not report the vendor-phy type
> but a different one instead, so add the possibility to override the
> phy type when the glue driver knows better than the ip block itself.
> 
> changes in v5:
> - disable CEC_5V option to make CEC actually work (Jonas)
> 
> changes in v4:
> - rebased onto 4.19-rc2 - no actual changes
> - added Rob's Ack on the dw-hdmi compatible
> 
> changes in v3:
> - split off phy driver into a separate series
> - only allow forcing vendor phy type
> - wording fixes and other nits
> 
> changes in v2:
> - phy: prevent overflow in tmdsclk calculation
>   as reported by Martin Cerveny
> - phy: use unsigned long for all tmdsclk rate uses
> - phy: simplify tmds rate calculation
> - dropped patch exporting some dw-hdmi phy functions
>   as a similar patch entered drm-misc already
> 
> Heiko Stuebner (6):
>   drm/bridge: dw-hdmi: allow forcing vendor phy-type
>   drm/rockchip: dw_hdmi: Allow outputs that don't need output switching
>   dt-bindings: allow optional phys in Rockchip dw_hdmi binding
>   drm/rockchip: dw_hdmi: allow including external phys
>   drm/rockchip: dw_hdmi: store rockchip_hdmi reference in phy_data
>     object
>   drm/rockchip: dw_hdmi: add dw-hdmi support for the rk3328

applied to drm-misc-next with the received Reviews
