From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 8 Jan 2013 15:31:16 -0200
Subject: [PATCH 7/7] ARM i.MX51 babbage: Add display support
In-Reply-To: <1357665800.2527.17.camel@pizza.hi.pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
 <CAOMZO5BnFZs+s-WFahtqyzCi15P9RBzKDzwdZNCJ4PmnQrFY1g@mail.gmail.com>
 <CAOMZO5AkRmhdB-JWQ5DFuQUJHibV7GGvvDeK7-cg7m8OnbHA_Q@mail.gmail.com>
 <201301081809.38537.marex@denx.de>
 <1357665800.2527.17.camel@pizza.hi.pengutronix.de>
Message-ID: <CAOMZO5AKwfyxuy1TfSxQxJ0Ehq7YpO0WN73bz4V6L804tdK0kA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Tue, Jan 8, 2013 at 3:23 PM, Philipp Zabel <p.zabel@pengutronix.de> wrote:

> Reordering the ipu_get_resources and imx_drm_add_crtc calls should resolve this:
>
> From: Philipp Zabel <p.zabel@pengutronix.de>
> Subject: [PATCH] staging: imx/drm: add crtc before registering interrupt
>  handler
>
> If the bootloader already enabled the display, the interrupt handler
> will be called as soon as it is registered. If the CRTC is not already
> added at this time, the call to imx_drm_handle_vblank will result in
> a NULL pointer dereference.
>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

This fixes the issue for me, thanks:

Tested-by: Fabio Estevam <fabio.estevam@freescale.com>
