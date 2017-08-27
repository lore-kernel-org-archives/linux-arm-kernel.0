From: wsa@the-dreams.de (Wolfram Sang)
Date: Sun, 27 Aug 2017 15:34:54 +0200
Subject: [PATCH v2 1/3] i2c: davinci: Preserve return value of devm_clk_get
In-Reply-To: <20170816221715.15027-2-fcooper@ti.com>
References: <20170816221715.15027-1-fcooper@ti.com>
 <20170816221715.15027-2-fcooper@ti.com>
Message-ID: <20170827133454.ffroiht5ayfqyr4k@ninjato>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 16, 2017 at 05:17:13PM -0500, Franklin S Cooper Jr wrote:
> The i2c driver can run into driver dependency issues if its loaded
> before a clock driver it depends on. Therefore, EPROBE_DEFER may be
> returned by devm_clk_get and should be returned in probe to allow the
> kernel to reprobe the driver at a later time. This patch allows the error
> value returned by devm_clk_get to be passed through and not overwritten.
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>

Applied to for-next, thanks!

Waiting for V3 of the other patches.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170827/5304240f/attachment.sig>
