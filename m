From: broonie@kernel.org (Mark Brown)
Date: Sun, 16 Feb 2014 09:14:35 +0800
Subject: [PATCH v4 1/2] spi:fsl-dspi:convert to use regmap and big-endian
 supports
In-Reply-To: <065acacc2f4f461cbd310eb54737a32e@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1392190146-18852-1-git-send-email-b44548@freescale.com>
 <065acacc2f4f461cbd310eb54737a32e@DM2PR03MB509.namprd03.prod.outlook.com>
Message-ID: <20140216011435.GT4451@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 07:33:17AM +0000, Li.Xiubo at freescale.com wrote:

> If needed, you should add the callbacks like:
> 	.readable_reg,
> 	.writeable_reg,
> 	.volatile_reg,

They're not 100% needed unless you have a cache in which case
volatile_reg() becomes important but it's definitely good practice to
add them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140216/6dc4a770/attachment-0001.sig>
