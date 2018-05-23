From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 13:23:11 -0500
Subject: [PATCH 05/15] drm/sun4i: Add TCON TOP driver
In-Reply-To: <20180519183127.2718-6-jernej.skrabec@siol.net>
References: <20180519183127.2718-1-jernej.skrabec@siol.net>
 <20180519183127.2718-6-jernej.skrabec@siol.net>
Message-ID: <20180523182311.GA8741@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 08:31:17PM +0200, Jernej Skrabec wrote:
> As already described in DT binding, TCON TOP is responsible for
> configuring display pipeline. In this initial driver focus is on HDMI
> pipeline, so TVE and LCD configuration is not implemented.
> 
> Implemented features:
> - HDMI source selection
> - clock driver (TCON and DSI gating)
> - connecting mixers and TCONS
> 
> Something similar also existed in previous SoCs, except that it was part
> of first TCON.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  drivers/gpu/drm/sun4i/Makefile             |   3 +-
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.c     | 256 +++++++++++++++++++++
>  drivers/gpu/drm/sun4i/sun8i_tcon_top.h     |  20 ++
>  include/dt-bindings/clock/sun8i-tcon-top.h |  11 +

This belongs with the binding doc patch.

>  4 files changed, 289 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.c
>  create mode 100644 drivers/gpu/drm/sun4i/sun8i_tcon_top.h
>  create mode 100644 include/dt-bindings/clock/sun8i-tcon-top.h
