From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 29 Dec 2010 22:26:35 +0100
Subject: [PATCH 1/9] spi/pxa2xx: register driver properly
In-Reply-To: <349566.41372.qm@web180301.mail.gq1.yahoo.com>
References: <20101229081120.GN8172@angua.secretlab.ca>
	<349566.41372.qm@web180301.mail.gq1.yahoo.com>
Message-ID: <20101229212635.GA31347@www.tglx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* David Brownell | 2010-12-29 09:00:36 [-0800]:

>I detect an effort to change the classic model for board initialization in Linux:  first set up
>and register all system/platform devices on each
>board then do the same for their drivers.  ("hardware first" ... "software second".

What are you suggesting? platform_driver_probe() does not work with
hotpluged devices.
I don't see a reason why it should be available to drivers. It is
unlikely that platform devices are hotlpluged but not impossible.

>- Dave

Sebastian
