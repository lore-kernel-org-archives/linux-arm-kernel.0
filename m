From: w.sang@pengutronix.de (Wolfram Sang)
Date: Fri, 2 Sep 2011 16:44:48 +0200
Subject: [RFC v2 PATCH 1/1] ASoC: soc-core: symmetry checking for each
	DAIs separately
In-Reply-To: <1314609314-22162-1-git-send-email-b29396@freescale.com>
References: <1314609314-22162-1-git-send-email-b29396@freescale.com>
Message-ID: <20110902144448.GH1901@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 29, 2011 at 05:15:14PM +0800, Dong Aisheng wrote:
> The orginal code does not cover the case that one DAI such as codec
> may be shared between other two DAIs(CPU).
> When do symmetry checking, altough the codec DAI requires symmetry,
> the two CPU DAIs may still be configured to run on different rates.
> 
> We change to check each DAI's state separately instead of only checking
> the dai link to prevent this issue.
> 
> Signed-off-by: Dong Aisheng <b29396@freescale.com>

Removes the race warning for me:

Tested-by: Wolfram Sang <w.sang@pengutronix.de>

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110902/a8f9e3d3/attachment.sig>
