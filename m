From: balbi@ti.com (Felipe Balbi)
Date: Mon, 25 Jun 2012 15:30:01 +0300
Subject: [PATCHv10 1/7] I2C: OMAP: I2C register restore only if context
 is lost
In-Reply-To: <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com>
References: <1340622702-21622-1-git-send-email-shubhrajyoti@ti.com>
 <1340622702-21622-2-git-send-email-shubhrajyoti@ti.com>
Message-ID: <20120625123000.GB30463@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jun 25, 2012 at 04:41:36PM +0530, Shubhrajyoti D wrote:
>  Currently i2c register restore is done always.
>  Adding conditional restore.
>  The i2c register restore is done only if the context is lost
>  or in case of error to be on the safe side.
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>

how will this ever work with DT ? I say we get rid of the OMAP-specific
API and build this "context lost" status directly on dev_pm_info and
have something like pm_runtime_lost_context() or something with pm QoS
tell you if a device has lost its context.

Also, your commit log doesn't really state any problems you might have
reached before, or any improvements wrt latency coming out of suspend
and so on.

IMHO, drivers need a generic way to differentiate if they're resuming
from OFF or RET, otherwise we will end up with a bunch of OMAP-specific
hackery on all drivers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120625/f28aa29c/attachment.sig>
