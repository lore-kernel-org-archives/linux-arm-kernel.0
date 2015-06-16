From: balbi@ti.com (Felipe Balbi)
Date: Tue, 16 Jun 2015 14:19:48 -0500
Subject: [PATCH] i2c: omap: improve duty cycle on SCL
In-Reply-To: <1434482276-1210-1-git-send-email-balbi@ti.com>
References: <1434482276-1210-1-git-send-email-balbi@ti.com>
Message-ID: <20150616191948.GC30496@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 16, 2015 at 02:17:56PM -0500, Felipe Balbi wrote:
> With this patch we try to be as close to 50%
> duty cycle as possible. The reason for this
> is that some devices present an erratic behavior
> with certain duty cycles.
> 
> One such example is TPS65218 PMIC which fails
> to change voltages when running @ 400kHz and
> duty cycle is lower than 34%.
> 
> The idea of the patch is simple:
> 
> calculate desired scl_period from requested scl
> and use 50% for tLow and 50% for tHigh.
> 
> tLow is calculated with a DIV_ROUND_UP() to make
> sure it's slightly higher than tHigh and to make
> sure that we end up within I2C specifications.
> 
> Kudos to Nishanth Menon and Dave Gerlach for helping
> debugging the TPS65218 problem found on AM437x SK.
> 
> Signed-off-by: Felipe Balbi <balbi@ti.com>

the patch is correct, but I sent the version written on top of v3.14,
I'll resend correct version, sorry.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150616/e6e85e1f/attachment.sig>
