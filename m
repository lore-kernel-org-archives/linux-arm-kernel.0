From: wsa@the-dreams.de (Wolfram Sang)
Date: Thu, 4 Dec 2014 19:29:11 +0100
Subject: [PATCH v3 3/5] i2c: recovery: change input parameter to
 i2c_adapter for prepare/unprepare_recovery
In-Reply-To: <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
References: <1417448047-15236-1-git-send-email-grygorii.strashko@ti.com>
 <1417448047-15236-4-git-send-email-grygorii.strashko@ti.com>
Message-ID: <20141204182910.GH7944@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 05:34:05PM +0200, Grygorii Strashko wrote:
> This patch changes type of input parameter for .prepare/unprepare_recovery()
> callbacks from struct i2c_bus_recovery_info * to struct i2c_adapter *.
> This allows to simplify implementation of these callbacks and avoid
> type conversations from i2c_bus_recovery_info to i2c_adapter.
> The i2c_bus_recovery_info can be simply retrieved from struct i2c_adapter
> which contains pointer on it.
> 
> CC: Sekhar Nori <nsekhar@ti.com>
> CC: Kevin Hilman <khilman@deeprootsystems.com>
> CC: Santosh Shilimkar <ssantosh@kernel.org>
> CC: Murali Karicheri <m-karicheri2@ti.com>
> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Ah, bus recovery, I need to have a closer look on this one. Scheduled
for 3.20.

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141204/14761970/attachment.sig>
