From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 8 Jun 2013 22:32:58 -0700
Subject: [PATCH] serial: omap: Fix device tree based PM runtime
In-Reply-To: <20130607230022.GP3331@atomide.com>
References: <20130607215835.GL3331@atomide.com> <87k3m5k07q.fsf@linaro.org>
 <20130607230022.GP3331@atomide.com>
Message-ID: <20130609053258.GA8104@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 04:00:22PM -0700, Tony Lindgren wrote:
> In the runtime_suspend function pdata is not being used, and
> also blocks the function in device tree based booting. Fix it
> by removing the unused pdata from the runtime_suspend function.
> 
> Further, context loss count is not being passed in pdata, so
> let's just reinitialize the port every time for those case.
> This can be further optimized later on for the device tree
> case by adding detection for the hardware state and possibly
> by adding a driver specific autosuspend timeout.
> 
> And doing this, we can then make the related dev_err into a
> dev_dbg message instead of an error.
> 
> In order for the wake-up events to work, we also need to set
> autosuspend_timeout to -1 if 0, and also device_init_wakeup()
> as that's not being done by the platform init code for the
> device tree case.
> 
> Note that this does not affect legacy booting, and in fact
> might make it work for the cases where the context loss info
> is not being passed in pdata.
> 
> Thanks to Kevin Hilman <khilman@linaro.org> for debugging
> and suggesting fixes for the autosuspend_timeout and
> device_init_wakeup() related initializiation.
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> Tested-by: Kevin Hilman <khilman@linaro.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
> ---
> 
> Here's an updated version with the white space fixed. Since
> you already acked it, I won't waste the opportunity to keep it
> in a single patch :)

It doesn't apply to my tree, so you'll have to refresh it against my
tty-next tree and resend it.

thanks,

greg k-h
