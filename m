From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 3 Aug 2011 08:52:37 +0900
Subject: [PATCH RESEND] ASoC: sgtl5000: fix cache handling
In-Reply-To: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
References: <1312306939-5140-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <20110802235236.GB30717@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2011 at 07:42:19PM +0200, Wolfram Sang wrote:
> Cache handling in this driver is broken. The chip has 16-bit registers, yet the
> register numbers also increase by 2 per register, i.e.  there are only
> even-numbered registers. The cache in this driver, though, simply increments
> register numbers, so it does need some mapping as seen in
> sgtl5000_restore_regs(), note the '>> 1':

Applied, thanks.
