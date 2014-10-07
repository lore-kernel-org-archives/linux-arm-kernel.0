From: broonie@kernel.org (Mark Brown)
Date: Tue, 7 Oct 2014 12:53:35 +0100
Subject: [PATCH 1/5] regulator: Add ena_gpio_valid config
In-Reply-To: <1412626635-7404-2-git-send-email-mpa@pengutronix.de>
References: <1412626635-7404-1-git-send-email-mpa@pengutronix.de>
 <1412626635-7404-2-git-send-email-mpa@pengutronix.de>
Message-ID: <20141007115335.GW4609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 06, 2014 at 10:17:11PM +0200, Markus Pargmann wrote:
> Most drivers do not set the ena_gpio field of struct regulator_config
> before passing it to the regulator core. This is fine as long as the
> gpio identifier that is passed is a positive integer. But the gpio
> identifier 0 is also valid. So we are not able to decide wether we got a
> real gpio identifier or not.
> 
> To be able to decide if it is a valid gpio that got passed, this patch
> adds a ena_gpio_valid field that should be set if ena_gpio is a valid
> gpio and should be used. It is a preperation patch for multiple patches
> that adapt the drivers and fix the regulator core checks for this field.

This should be part of the patch adding meaningful behaviour for the
flag, it's pointless separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/8eb8454c/attachment.sig>
