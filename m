From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 6 Sep 2011 10:28:02 +0200
Subject: [PATCH] ARM: i.MX5/mm: use static mapping for TZIC
In-Reply-To: <1314098974-8220-1-git-send-email-jason.hui@linaro.org>
References: <1314098974-8220-1-git-send-email-jason.hui@linaro.org>
Message-ID: <20110906082802.GD28816@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 23, 2011 at 07:29:34PM +0800, Jason Liu wrote:
> We can use static mapping for TZIC to get rid of the
> duplicated code for ioremap and the error handling of
> ioremap, which will made code more clean and consistent.
> 
> Signed-off-by: Jason Liu <jason.hui@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> v2: Remove the MX51_DEBUG related mapping which is conflict with TZIC.
>     MX51_DEBUG related mapping is dead code, no-one use it.
I'd prefer to have that in two patches:

 - remove DEBUG mapping
 - add TZIC mapping

and in both cases adapt the listing in
arch/arm/plat-mxc/include/mach/hardware.h please.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
