From: greg@kroah.com (Greg KH)
Date: Tue, 28 Jun 2011 14:01:12 -0700
Subject: [PATCH v5 1/1] drivers:staging:pruss: add pruss staging mfd
	driver.
In-Reply-To: <1306827939-4133-2-git-send-email-subhasish@mistralsolutions.com>
References: <1306827939-4133-1-git-send-email-subhasish@mistralsolutions.com>
	<1306827939-4133-2-git-send-email-subhasish@mistralsolutions.com>
Message-ID: <20110628210112.GA31081@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 31, 2011 at 01:15:39PM +0530, Subhasish Ghosh wrote:
> This patch adds the pruss MFD driver and associated include files.
> For details regarding the PRUSS please refer the folowing link:
> http://processors.wiki.ti.com/index.php/Programmable_Realtime_Unit_Subsystem
> 
> The rational behind the MFD driver being the fact that multiple devices can
> be implemented on the cores independently. This is determined by the nature
> of the program which is loaded into the PRU's instruction memory.
> A device may be de-initialized and another loaded or two different devices
> can be run simultaneously on the two cores.
> It's also possible, as in our case, to implement a single device on both
> the PRU's resulting in improved load sharing.
> 
> Signed-off-by: Subhasish Ghosh <subhasish@mistralsolutions.com>

Please refresh my memory as to why this can't get merged into the
"normal" part of the kernel?

> --- /dev/null
> +++ b/drivers/staging/pruss/TODO
> @@ -0,0 +1,14 @@
> +TODO:
> +
> +0. Functionality wise, everything works.
> +
> +1. Currently the plan is to add sysfs attributes for
> +	a. prux/load
> +	b. prux/unload
> +	c. prux/run
> +	d. prux/halt
> +   These will add to a more dynamic firmware management for the PRU.

Why sysfs?


> +
> +2. But, not sure how the fdt will effect these entries.
> +
> +Please send patches to Greg Kroah-Hartman <greg@kroah.com>.

Don't you want people to Cc: you as well?

I'm not going to adopt this driver, I have enough as it is :)

thanks,

greg k-h
