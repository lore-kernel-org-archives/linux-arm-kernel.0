From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 12 Feb 2010 12:01:00 +0100
Subject: [WARNING] mxc_w1_probe should not be __init modified
In-Reply-To: <1265971348.2484.63.camel@realization>
References: <1265971348.2484.63.camel@realization>
Message-ID: <20100212110100.GA18221@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, Feb 12, 2010 at 11:42:28AM +0100, Alberto Panizzo wrote:
> Today linux-next build, report this:
> 
> WARNING: drivers/w1/masters/built-in.o(.data+0x0): Section mismatch in reference from the variable mxc_w1_driver to the function .init.text:mxc_w1_probe()
> The variable mxc_w1_driver references
> the function __init mxc_w1_probe()
> If the reference is valid then annotate the
> variable with __init* or __refdata (see linux/init.h) or name the variable:
> *_template, *_timer, *_sht, *_ops, *_probe, *_probe_one, *_console, 
> 
> 
> I don't know if should be modified with __devinit instead or nothing at all.
Yes it should use __devinit.  If you need a reason, try

	cd /sys/bus/platform/drivers/mxc_w1
	echo -n mxc_w1.0 > unbind
	echo -n mxc_w1.0 > bind

While at it, mxc_w1_remove can be moved to devexit.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
