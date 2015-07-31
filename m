From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 31 Jul 2015 12:51:37 +0200
Subject: [PATCH] i2c: core: only use set_scl for bus recovery after
 calling prepare_recovery
In-Reply-To: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
References: <1436366106-11779-1-git-send-email-jlu@pengutronix.de>
Message-ID: <20150731105137.GG1522@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 04:35:06PM +0200, Jan Luebbe wrote:
> Using set_scl may be ineffective before calling the driver specific
> prepare_recovery callback, which might change into a test mode. So
> instead of setting SCL in i2c_generic_scl_recovery, move it to
> i2c_generic_recovery (after the optional prepare_recovery).
> 
> Signed-off-by: Jan Luebbe <jlu@pengutronix.de>

Applied to for-current, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150731/77823461/attachment-0001.sig>
