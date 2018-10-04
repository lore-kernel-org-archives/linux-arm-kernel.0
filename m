From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 4 Oct 2018 21:56:05 +0200
Subject: [PATCH v2 2/2] drm/sun4i: tcon: prevent tcon->panel dereference
 if null
In-Reply-To: <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
References: <9a545739-eed5-7af1-3b75-108bdd3427a2@micronovasrl.com>
 <20181003142458.33120-1-giulio.benetti@micronovasrl.com>
 <20181003142458.33120-2-giulio.benetti@micronovasrl.com>
Message-ID: <20181004195605.txvbkshvxklyzxyb@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2018 at 04:24:58PM +0200, Giulio Benetti wrote:
> If using tcon with VGA,

We don't have support for VGA at the moment. Or are you talking about
using a VGA bridge?

> tcon->panel will be null(0), this will cause segmentation fault when
> trying to dereference tcon->panel->connector.

It's not a segmentation fault, but a null pointer dereference. And
that case will also happen with bridges.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181004/fc276c6c/attachment.sig>
