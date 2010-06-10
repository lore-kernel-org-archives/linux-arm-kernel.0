From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 10 Jun 2010 10:48:34 +0200
Subject: [PATCH 1/5] [ARM] Remove unused PARAMS_PHYS from
	arch/arm/boot/compressed
In-Reply-To: <1275550613-9553-2-git-send-email-eric.miao@canonical.com>
References: <1275550613-9553-1-git-send-email-eric.miao@canonical.com>
	<1275550613-9553-2-git-send-email-eric.miao@canonical.com>
Message-ID: <20100610084834.GB3422@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo,

On Thu, Jun 03, 2010 at 03:36:49PM +0800, Eric Miao wrote:
> From: Eric Miao <eric.y.miao@gmail.com>
> 
> The only reference in arch/arm/boot/compressed to PARAMS_PHYS is
> params() in head.S, which can be directly converted to the exact
> address as specified by arch/arm/mach-rpc/Makefile.boot.
> 
> Signed-off-by: Eric Miao <eric.miao@canonical.com>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

So params_phys-y is only used in arch/arm/boot/bootp.  Is this still
used?  It doesn't check r2 for finding the atag list but only uses
params_phys-y.  So according to Keith's fail-safe method for the removal
of cruft[1] bootp can be deleted.   (Unless I didn't see that the kernel
still finds the atag list at params_phys-y if r2 isn't pointing to the
correct address.)  (OK, if r2 and params_phys-y agree, it could still
work.)

Who cares to fix bootp?  Should we delete it?

Best regards
Uwe

[1] 1. promise that there will be long-term support.
    2. Realize failure.
    3. "Accidentally" break things in the code.
    4. Let a few years go by, and note that nobody has complained about
       the broken features.
    5. Remove the code since it is obviously not being used.

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
