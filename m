From: ben@fluff.org (Ben Dooks)
Date: Mon, 5 Apr 2010 23:44:02 +0100
Subject: [PATCH v2] i2c-s3c2410: Remove unconditional 1ms delay on each
	transfer
In-Reply-To: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1270214109-28226-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <20100405224402.GA32401@fluff.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 02, 2010 at 02:15:09PM +0100, Mark Brown wrote:
> The S3C I2C controller indicates completion of I2C transfers before
> the bus has a stop condition on it. In order to ensure that we do not
> attempt to start a new transfer before the bus is idle the driver
> currently inserts a 1ms delay. This is vastly larger than is generally
> required and has a visible effect on performance under load, such as
> when bringing up audio CODECs or reading back status information with
> non-bulk I2C reads.

ok, so far no problems with this on an s3c2440. I'll add it to the
next tree.

-- 
Ben (ben at fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
