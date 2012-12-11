From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 11 Dec 2012 14:52:43 +0000
Subject: [PATCH] mmc: mmci: Gate the clock in runtime suspend to save power
In-Reply-To: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
References: <1355235474-12783-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <20121211145243.GQ14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 11, 2012 at 03:17:54PM +0100, Ulf Hansson wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
> 
> The amba bus is already performing same actions but for the apb_pclk.
> So here we just make sure the clock to card is gated as well to save
> more power. At runtime resume we will thus restore the clock again.

And how exactly do you ensure the requirement that a certain number of
clocks is supplied to the card after the last command before you cut
the clock?
