From: wsa@the-dreams.de (Wolfram Sang)
Date: Fri, 17 May 2013 14:17:56 +0200
Subject: [PATCH 1/9] I2C: mv64xxx: work around signals causing I2C
 transactions to be aborted
In-Reply-To: <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
References: <20130516202921.GW18614@n2100.arm.linux.org.uk>
 <E1Ud4pH-0004JQ-Jq@rmk-PC.arm.linux.org.uk>
Message-ID: <20130517121752.GC2939@katana>
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

Applied to for-current, thanks!

Rest will be reviewed later...
