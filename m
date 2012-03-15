From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 15 Mar 2012 17:43:44 +0000
Subject: [PATCH v3 4/6] mfd: mc13xxx-core: use regmap for register access
In-Reply-To: <1331757790-10583-5-git-send-email-marc@cpdesign.com.au>
References: <1331757790-10583-1-git-send-email-marc@cpdesign.com.au>
 <1331757790-10583-5-git-send-email-marc@cpdesign.com.au>
Message-ID: <20120315174343.GQ3138@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 15, 2012 at 07:43:08AM +1100, Marc Reilly wrote:
> This change converts the mc13xxx core to use regmap rather than direct
> spi r/w.
> The spidev member of mc13xxx struct becomes redundant and is removed.
> Extra debugging aids are added to mc13xxx_reg_rmw.
> Mutex init is moved to before regmap init.

Reviwed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

For rmw please push the trace down into regmap as a new tracepoint if
you find it useful; one of the wins from regmap is intended to be the
trace and diagnostic infrastructure you get for free with it.  At the
minute only the underlying reads and writes have trace.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120315/ea3df634/attachment.sig>
