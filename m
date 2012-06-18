From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 18 Jun 2012 17:44:02 +0100
Subject: [PATCH 15/16] ARM: fiq: save FIQ_START by passing absolute fiq
 number
In-Reply-To: <20120618143128.GF19249@S2101-09.ap.freescale.net>
References: <1339653587-4832-1-git-send-email-shawn.guo@linaro.org>
 <1339653587-4832-16-git-send-email-shawn.guo@linaro.org>
 <20120618143128.GF19249@S2101-09.ap.freescale.net>
Message-ID: <20120618164402.GA18630@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 18, 2012 at 10:31:30PM +0800, Shawn Guo wrote:
> Hi Russell,
> 
> Do you have any comment, or may I have your ack on this patch?

Yes, I haven't seen it, and now that I have I don't like it.

FIQs should be an entirely separate number space from IRQs, as we
may want to totally decouple them from the IRQ stuff (we probably
should have already done this when genirq came along.)

About the only stuff FIQs use is the enable/disable_irq as a short
cut to dealing with the mask registers.
