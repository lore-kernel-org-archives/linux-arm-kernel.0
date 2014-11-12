From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 12 Nov 2014 15:57:55 +0200
Subject: [PATCH 1/4] video: omapdss: Add opa362 driver
In-Reply-To: <1415051968-4878-2-git-send-email-marek@goldelico.com>
References: <1415051968-4878-1-git-send-email-marek@goldelico.com>
 <1415051968-4878-2-git-send-email-marek@goldelico.com>
Message-ID: <54636763.10605@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,


On 03/11/14 23:59, Marek Belisko wrote:
> opa362 is amplifier for videoand can be connected to the tvout pads
> of the OMAP3. It has one gpio control for enable/disable of the output
> (high impedance).
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> ---
>  drivers/video/fbdev/omap2/displays-new/Kconfig     |   6 +
>  drivers/video/fbdev/omap2/displays-new/Makefile    |   1 +
>  .../fbdev/omap2/displays-new/amplifier-opa362.c    | 347 +++++++++++++++++++++
>  3 files changed, 354 insertions(+)
>  create mode 100644 drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c

This doesn't even compile:

drivers/video/fbdev/omap2/displays-new/amplifier-opa362.c:207:28: error:
dereferencing pointer to incomplete type
  ddata->enable_gpio = pdata->enable_gpio;

And it seems to have fields for bypass and bypass which are handled in
the devconf1 patch.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141112/376c65b7/attachment.sig>
