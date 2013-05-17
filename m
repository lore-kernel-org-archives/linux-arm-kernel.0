From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 17 May 2013 10:06:48 -0700
Subject: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
In-Reply-To: <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Message-ID: <20130517170648.GD28484@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 16, 2013 at 09:30:59PM +0100, Russell King wrote:
> Do not use interruptible waits in an I2C driver; if a process uses
> signals (eg, Xorg uses SIGALRM and SIGPIPE) then these signals can
> cause the I2C driver to abort a transaction in progress by another
> driver, which can cause that driver to fail.  I2C drivers are not
> expected to abort transactions on signals.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---

I don't have hardware to test but I have no issues with these patches so,
FWIW:

Acked-by: Mark A. Greer <mgreer@animalcreek.com>

for the entire series.
