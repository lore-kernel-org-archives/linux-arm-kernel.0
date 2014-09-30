From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Sep 2014 17:45:10 +0100
Subject: [PATCH] ASoC: fsl: fix dependencies for wm8962
In-Reply-To: <1950588.ErdGoiHh8p@wuerfel>
References: <1950588.ErdGoiHh8p@wuerfel>
Message-ID: <20140930164510.GF4273@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 30, 2014 at 01:43:41PM +0200, Arnd Bergmann wrote:
> The wm8962 driver uses the input subsystem, but is selected by
> SND_SOC_FSL_ASOC_CARD, which can be built with CONFIG_INPUT disabled,
> resulting in this link error:

That select shouldn't be there in the first place, I asked Nicolin to
fix this when I applied the driver but he's not got round to it yet.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140930/e13a18ea/attachment.sig>
