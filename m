From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Jul 2015 15:00:46 +0100
Subject: [RFC PATCH 2/2] dt: spi: s3c64xx: add compatible to
 controller-data
In-Reply-To: <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
References: <cover.1438170519.git.hramrach@gmail.com>
 <557c1962448393b2a8736f26bfa2a3a5ba4aeb7a.1438170519.git.hramrach@gmail.com>
Message-ID: <20150729140046.GB11082@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 29, 2015 at 12:19:57PM +0200, Michal Suchanek wrote:

Please use subject lines matching the style for the subsytsem so people
can spot that the patch is in some way relevant.

> The controller-data subnode has no compatible. This can lead to other
> drivers getting confused by it. Add a compatible to make devicetreee
> unambiguous.

I can't tell from this commit message what the issue you're trying to
fix is, sorry.  Nodes without compatible strings are entirely normal and
don't need compatible strings.  It sounds like a bug in whatever other
driver is becoming confused.

> +	if (!of_get_property(data_np, "compatible", NULL) ||
> +	    strcmp(of_get_property(data_np, "compatible", NULL),
> +		   "samsung,s3c-controller-data"))
> +		dev_err(&spi->dev, "child node 'controller-data' does not have correct compatible\n");

This will break all existing users which is not acceptable for
mainline, we need to preserve compatibility with existing device trees.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150729/e4a79567/attachment.sig>
