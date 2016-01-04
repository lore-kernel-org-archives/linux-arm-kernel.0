From: broonie@kernel.org (Mark Brown)
Date: Mon, 4 Jan 2016 15:45:11 +0000
Subject: [PATCH] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <9222694.IRNnfpj6Tn@wuerfel>
References: <2884997.s8B8BuE04L@wuerfel> <20160102141746.GH16023@sirena.org.uk>
 <9222694.IRNnfpj6Tn@wuerfel>
Message-ID: <20160104154511.GL16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 04:17:47PM +0100, Arnd Bergmann wrote:
> On Saturday 02 January 2016 14:17:46 Mark Brown wrote:

> > This would be a lot nicer if there was an __always_null annotation we
> > could put on of_node for !OF configurations, that'd Just Work and this
> > can't be the only case where we have this idiom.

> How about an inline helper like

> static inline struct device_node *dev_of_node(struct device *dev)
> {
> 	if (IS_ENABLED(CONFIG_OF))
> 		return dev->of_node;	
> }

Yeah, that'd work as well (with the correction Russell mentioned) - it's
a bit more typing but we already do similar things for the ID tables and
it looks nicer than the IS_ENABLED() in code does.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160104/ce59d166/attachment.sig>
