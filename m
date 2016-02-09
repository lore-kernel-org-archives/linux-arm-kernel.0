From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Feb 2016 12:41:33 +0000
Subject: [PATCH V5 1/2] regulator: Add document for MT6323 regulator
In-Reply-To: <1454874037-38905-1-git-send-email-blogic@openwrt.org>
References: <1454874037-38905-1-git-send-email-blogic@openwrt.org>
Message-ID: <20160209124133.GE13270@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 07, 2016 at 08:40:36PM +0100, John Crispin wrote:

> +Required properties:
> +- compatible: "mediatek,mt6323-regulator"

I'm really not happy with MFD subfunctions like this which add no
information over the parent device name appearing directly in the
binding, it results in us putting Linux specifics about how we split the
device up into the driver.  It's not like this could realistically be
used separately to the parent device.  Just have the MFD create the
device directly or if the individual regulators are reusable IPs which
can share a driver then describe them as such in the DT.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160209/b8ecaa5a/attachment.sig>
