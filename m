From: broonie@kernel.org (Mark Brown)
Date: Mon, 25 May 2015 18:32:44 +0100
Subject: [PATCH 10/21] regulator: core: Probe regulators on demand
In-Reply-To: <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
 <1432565608-26036-11-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <20150525173244.GE21577@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 25, 2015 at 04:53:14PM +0200, Tomeu Vizoso wrote:

> When looking up a regulator through its DT node, ensure that the
> corresponding device has been registered.

I'm sorry but I'm going to need a much better changelog to review this
patch.  I can't entirely tell what the intended effect is supposed to
be, the subject line says we're probing things and the body says we're
registering things which aren't the same thing at all.

>  		if (node) {
> +			of_platform_device_ensure(node);

This function doesn't appear in git so I'm guessing that some other
patch in the series adds it.  See my reply to the first patch...

The obvious questions here based on the name are why we're doing
something specific to platform devices and why this isn't something
we're abstracting in the driver core (or at least generic firmware code)
- we're going to have the same thing with ACPI.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150525/e260564f/attachment.sig>
