From: david-b@pacbell.net (David Brownell)
Date: Wed, 29 Dec 2010 09:00:36 -0800 (PST)
Subject: [PATCH 1/9] spi/pxa2xx: register driver properly
In-Reply-To: <20101229081120.GN8172@angua.secretlab.ca>
Message-ID: <349566.41372.qm@web180301.mail.gq1.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> Date: Wednesday, December 29, 2010, 12:11 AM
> On Thu, Dec 02, 2010 at 06:47:29PM
> +0100, Sebastian Andrzej Siewior wrote:
> > use platform_driver_register instead of
> platform_driver_probe. The
> > latter only checks available devices at the time of
> calling. So if a
> > device gets inserter at a later point in time then the
> driver will never
> > play with it.


I detect an effort to change the classic model for board initialization in Linux:  first set up
and register all system/platform devices on each
board then do the same for their drivers.  ("hardware first" ... "software second".

(Without such a change, there's no need for
 patches like this (of which I've recently
seen a few).

I've not seen discussion about the desirability
of such a change.

- Dave


Has this change
