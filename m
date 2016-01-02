From: broonie@kernel.org (Mark Brown)
Date: Sat, 2 Jan 2016 14:17:46 +0000
Subject: [PATCH] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <2884997.s8B8BuE04L@wuerfel>
References: <2884997.s8B8BuE04L@wuerfel>
Message-ID: <20160102141746.GH16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 02, 2016 at 12:19:52AM +0100, Arnd Bergmann wrote:

> -		if (i2c_client->dev.of_node) {
> +		if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {

This would be a lot nicer if there was an __always_null annotation we
could put on of_node for !OF configurations, that'd Just Work and this
can't be the only case where we have this idiom.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160102/54dc35cc/attachment-0001.sig>
