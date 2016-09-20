From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 20 Sep 2016 21:05:04 +0800
Subject: [PATCH] tty: amba-pl011: uart_amba_port is not available with
 earlycon function
In-Reply-To: <1474092878-30034-1-git-send-email-shawn.guo@linaro.org>
References: <1474092878-30034-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20160920130504.GF3744@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2016 at 02:14:38PM +0800, Shawn Guo wrote:
> Commit 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE
> device") changes earlycon function pl011_putc() to use a pointer to
> uart_amba_port.  This causes a regression when earlycon is enabled,
> because uart_amba_port is not available yet at earlycon time.  Let's
> revert the change on pl011_putc() to fix the regression.
> 
> The earlycon support for ZTE device can probably be added later by
> declaring a new earlycon setup function with a vendor specific
> compatible.
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Fixes: 0e125a5facf8 ("tty: amba-pl011: define flag register bits for ZTE device")
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Hi Sudeep,

Can you please confirm if the patch fixes your problem, so that Greg
knows whether it should be applied?  Thanks.

Shawn
