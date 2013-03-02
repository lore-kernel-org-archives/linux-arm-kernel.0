From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 19:40:07 +0000
Subject: [PATCH 2/2] gpio/omap: warn if bank is not enabled on setting irq
 type
In-Reply-To: <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
References: <1362158568-1624-1-git-send-email-jon-hunter@ti.com>
 <1362158568-1624-3-git-send-email-jon-hunter@ti.com>
Message-ID: <20130302194007.2307C3E1165@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 1 Mar 2013 11:22:48 -0600, Jon Hunter <jon-hunter@ti.com> wrote:
> For OMAP devices, if a gpio is being used as an interrupt source but has
> not been requested by calling gpio_request(), a call to request_irq()
> may cause the kernel hang because the gpio bank may be disabled and
> hence the register access will fail. To prevent such hangs, test for
> this case and warn if this is detected.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>

Applied, thanks.

g.
