From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 29 Aug 2016 15:23:47 +0800
Subject: [PATCH] ARM: imx: add cpuidle support for i.mx6ul
In-Reply-To: <1472033090.2780.20.camel@pengutronix.de>
References: <1472055231-28434-1-git-send-email-Anson.Huang@nxp.com>
 <1472029735.2780.3.camel@pengutronix.de>
 <AM3PR04MB131584BCC7F2389B8C9437C7F5EA0@AM3PR04MB1315.eurprd04.prod.outlook.com>
 <1472033090.2780.20.camel@pengutronix.de>
Message-ID: <20160829072347.GJ30790@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 12:04:50PM +0200, Lucas Stach wrote:
> Personally I would just remove the condition, but if you are concerned
> about the double L1 flush overhead (I wouldn't worry about this, it
> should be negligible) you should really make this conditional on an
> architected L2 being present. Making it conditional on the outer cache
> being absent is confusing.

Anson,

Is there any concern or problem if we follow Lucas' suggestion to
unconditionally calls flush_cache_all() here?

Shawn
