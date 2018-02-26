From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 26 Feb 2018 10:38:00 +0100
Subject: [PATCH 01/15] clk: sunxi-ng: Add check for minimal rate to NM PLLs
In-Reply-To: <20180224214545.3740-2-jernej.skrabec@siol.net>
References: <20180224214545.3740-1-jernej.skrabec@siol.net>
 <20180224214545.3740-2-jernej.skrabec@siol.net>
Message-ID: <20180226093800.uwbo54wrdcwmsyzh@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sat, Feb 24, 2018 at 10:45:31PM +0100, Jernej Skrabec wrote:
> Some NM PLLs doesn't work well when their output clock rate is set below
> certain rate.
> 
> Add support for that constrain.

In such a case, you should round the rate to the minimum the clock can
operate at, and not return an error.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180226/f86454cc/attachment.sig>
