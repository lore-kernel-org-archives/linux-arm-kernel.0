From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 24 Jun 2011 13:41:55 +0100
Subject: [PATCH] INPUT:Add ABS_PRESSURE input event support for
	touchscreen driver
In-Reply-To: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
References: <1308881738-6392-1-git-send-email-wdgvip@gmail.com>
Message-ID: <20110624124154.GC19804@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 24, 2011 at 10:15:38AM +0800, Wu DaoGuang wrote:
> The touchscreen driver s3c2410_ts.c doesn't work well when using
> the tslib, an abstraction layer for touchscreen panel events.
> Tslib needs ABS_X ABS_Y and ABS_PRESSURE events to report, but only
> the former two the driver can provide.

It seems much more sane to fix this in tslib, the kernel is not actually
reporting pressure meaningfully here and there's already BTN_TOUCH to
report if the pen is down.
