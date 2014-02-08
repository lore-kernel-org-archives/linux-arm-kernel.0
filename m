From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 8 Feb 2014 12:01:28 -0500
Subject: [PATCH] i2c: mv64xxx: Fix locked bus when offload is selected
 but not used on a message
In-Reply-To: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
References: <1391770588-1344-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20140208170128.GI8533@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 07, 2014 at 11:55:54AM +0100, Gregory CLEMENT wrote:
> Offload can be used only on regular transactions and for 1 to byte
> transfers. In the other cases we switch back to usual work flow.
> 
> In this case we need to call mv64xxx_i2c_prepare_for_io() as this
> function is not used when we try to use offloading.
> 
> This commit adds this missing call when offloading have failed in the
> MV64XXX_I2C_ACTION_OFFLOAD_SEND_START case.
> 
> This fix the timeout seen when the the i2c driver try to access an
> address where the device is absent on the Armada XP bases board.
> 
> Cc: stable at vger.kernel.org # v3.12+
> Fixes: 930ab3d403ae (i2c: mv64xxx: Add I2C Transaction Generator support)
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  drivers/i2c/busses/i2c-mv64xxx.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Acked-by: Jason Cooper <jason@lakedaemon.net>

thx,

Jason.
