From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 17 Jun 2012 17:21:42 +0100
Subject: [PATCH v3 1/2] mmc: mmci.c: Defer probe() in case of yet
 uninitialized GPIOs
In-Reply-To: <1339927893-8842-2-git-send-email-stigge@antcom.de>
References: <1339927893-8842-1-git-send-email-stigge@antcom.de>
 <1339927893-8842-2-git-send-email-stigge@antcom.de>
Message-ID: <20120617162142.GA26446@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 17, 2012 at 12:11:32PM +0200, Roland Stigge wrote:
> If the GPIOs used by the MMCI driver are not registered yet when the driver is
> probe()d, they can't be used. This happens if the mmci driver is probed before
> the respective GPIO controller (e.g. on the LPC32xx EA3250 board, the PCA9532
> GPIO controller would be initialized via DT after mmci). Therefore, we defer
> mmci in this case.

I'm much happier with this.  Provided the change to the GPIO OF stuff is
fine.
