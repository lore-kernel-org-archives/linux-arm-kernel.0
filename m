From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 22 Mar 2010 22:02:04 +0100
Subject: [PATCH 2/3] i2c/pxa: only define 'blue_murder'-function if
	DEBUG is #defined
In-Reply-To: <20100228155502.GB16745@n2100.arm.linux.org.uk>
References: <20100224110044.GB15181@pengutronix.de>
	<1267009306-17227-2-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100228155502.GB16745@n2100.arm.linux.org.uk>
Message-ID: <20100322210204.GB10157@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Sun, Feb 28, 2010 at 03:55:02PM +0000, Russell King - ARM Linux wrote:
> On Wed, Feb 24, 2010 at 12:01:45PM +0100, Uwe Kleine-K?nig wrote:
> > From: Wolfram Sang <w.sang@pengutronix.de>
> > 
> > This talkative function is also called on timeouts. As timeouts can
> > happen on regular writes to EEPROMs (no error case), this creates false
> > positives.  Giving lots of details is interesting only for developers
> > anyhow, so just use the function if DEBUG is #defined.
> 
> Are you sure this is safe?  If you time out the write before it completes,
> how do you know if the write was successful?
> 
> I don't think this is "no error code" nor "false positive".  If the timeout
> is too short for your EEPROMs, then the timeout needs to be increased.
any thoughts about this by you?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
