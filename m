From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 16:05:42 +0000
Subject: [PATCH 03/17] mmc: mmci: Mask IRQs for all variants during
 runtime suspend
In-Reply-To: <1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140218160542.GH21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 04:58:44PM +0100, Ulf Hansson wrote:
> In runtime suspended state, we are not expecting IRQs and thus we can
> safely mask them, not only for pwrreg_nopower variants but for all.
> 
> Obviously we then also need to make sure we restore the IRQ mask while
> becoming runtime resumed.

So, what happens when this patch is applied, and a SDIO card is attached
which expects to receive interrupts at any moment?

Given that I've run into this during the last week with a SDHCI controller,
I'm not that thrilled with other interfaces doing the same broken thing.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
