From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Feb 2014 16:46:14 +0000
Subject: [PATCH 03/17] mmc: mmci: Mask IRQs for all variants during
 runtime suspend
In-Reply-To: <CAPDyKFq3uAoo7p-7hZgBmMJ4jf9A7dC0aUZJYUE0z1Qq5W=0bw@mail.gmail.com>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
 <1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
 <20140218160542.GH21483@n2100.arm.linux.org.uk>
 <CAPDyKFq3uAoo7p-7hZgBmMJ4jf9A7dC0aUZJYUE0z1Qq5W=0bw@mail.gmail.com>
Message-ID: <20140218164614.GI21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 18, 2014 at 05:36:52PM +0100, Ulf Hansson wrote:
> If we add SDIO irq support to mmci in future; parts of that
> implementation includes a re-route of DAT1 to a GPIO irq when entering
> runtime suspend state. The mmci HW will in runtime suspend state, not
> be responsible for handling irqs, which is the same as of today.

Note that the "irq thread" in sdio_irq is scheduled for destruction -
it's buggy when the system is under high load and a driver claims a
SDIO irq.  Sched people hate it too...

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
