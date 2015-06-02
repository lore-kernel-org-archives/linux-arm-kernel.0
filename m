From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 3 Jun 2015 02:55:33 +0900
Subject: [PATCH v2] i2c: designware: Avoid unnecessary resuming during
 system suspend
In-Reply-To: <1432132393-693-1-git-send-email-jszhang@marvell.com>
References: <1432132393-693-1-git-send-email-jszhang@marvell.com>
Message-ID: <20150602175532.GD1494@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 20, 2015 at 10:33:13PM +0800, Jisheng Zhang wrote:
> Commit 1fc2fe204cb9 ("i2c: designware: Add runtime PM hooks") adds
> runtime pm support using the same ops for system pm and runtime pm.
> When suspend to ram, the i2c host may have been runtime suspended, thus
> i2c_dw_disable() hangs.
> 
> Previously, I fixed this issue by separating ops for system pm and
> runtime pm, then in the system suspend/resume path, runtime pm apis are
> used to ensure the device is at correct state.
> 
> But as Mika Westerberg pointed out: it sounds a bit silly to resume the
> device just because you want to call i2c_dw_disable() for it before
> suspending again. He then suggested an elegant solution which keeps the
> device runtime suspended during system suspend with the help of
> 'dev->power.direct_complete'. This patch adopted this solution, and in
> fact Mika provided the main code.
> 
> Signed-off-by: Jisheng Zhang <jszhang@marvell.com>

Fixed the 80 char thingie and applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150603/2f6101dd/attachment.sig>
