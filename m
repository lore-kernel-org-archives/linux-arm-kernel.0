From: broonie@kernel.org (Mark Brown)
Date: Sat, 5 Mar 2016 14:39:34 +0900
Subject: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized variable access
In-Reply-To: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Message-ID: <20160305053934.GI18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 06:07:32PM +0100, Arnd Bergmann wrote:

> -		if (i2c_client->dev.of_node) {
> +		if (IS_ENABLED(CONFIG_OF) && i2c_client->dev.of_node) {

This feels it's going to be happening a lot and we should probably have
a dev_has_of_node() helper that does the IS_ENABLED() check.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160305/5f55b1dd/attachment.sig>
