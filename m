From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Nov 2015 14:30:55 +0100
Subject: [PATCH 07/71] ncr5380: Split NCR5380_init() into two functions
In-Reply-To: <20151118083457.131801599@telegraphics.com.au>
References: <20151118083455.331768508@telegraphics.com.au>
 <20151118083457.131801599@telegraphics.com.au>
Message-ID: <564DCF0F.6030601@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/2015 09:35 AM, Finn Thain wrote:
> This patch splits the NCR5380_init() function into two parts, similar
> to the scheme used with atari_NCR5380.c. This avoids two problems.
> 
> Firstly, NCR5380_init() may perform a bus reset, which would cause the
> chip to assert IRQ. The chip is unable to mask its bus reset interrupt.
> Drivers can't call request_irq() before calling NCR5380_init(), because
> initialization must happen before the interrupt handler executes. If
> driver initialization causes an interrupt it may be problematic on some
> platforms. To avoid that, first move the bus reset code into
> NCR5380_maybe_reset_bus().
> 
> Secondly, NCR5380_init() contains some board-specific interrupt setup code
> for the NCR53C400 that does not belong in the core driver. In moving this
> code, better not re-order interrupt initialization and bus reset. Again,
> the solution is to move the bus reset code into NCR5380_maybe_reset_bus().
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
