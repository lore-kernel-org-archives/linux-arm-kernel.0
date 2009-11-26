From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 26 Nov 2009 10:02:52 +0100
Subject: [PATCH 1/1] Remove suspend/resume functionality, add dynamic
	clocking
In-Reply-To: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
References: <083DF309106F364B939360100EC290F804F55C9225@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20091126090252.GB12179@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

can you please add something like "i2c-pnx: " to the subject?
(Actually it's a great strategy *not* to put it into the Subject.  This
way it attracts far more attention :-)

> Remove suspend/resume functionality, I2C driver gates clock on
> only when an I2C transaction is in progress
What happens when the machine suspends while a transfer is in progress?
(This might be a problem that already existed before.)  If this is
really a problem the easiest "fix" is to let the suspend callback return
-EBUSY in this case.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
