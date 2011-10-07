From: greg@kroah.com (Greg KH)
Date: Thu, 6 Oct 2011 23:43:49 -0700
Subject: [PATCH 1/5] drivercore: add new error value for deferred probe
In-Reply-To: <1317963790-29426-2-git-send-email-manjugk@ti.com>
References: <1317963790-29426-1-git-send-email-manjugk@ti.com>
	<1317963790-29426-2-git-send-email-manjugk@ti.com>
Message-ID: <20111007064349.GD27508@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 07, 2011 at 10:33:06AM +0500, G, Manjunath Kondaiah wrote:
> 
> Add new error value so that drivers can request deferred probe
> from drivercore.
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Reported-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> Cc: linux-omap at vger.kernel.org
> Cc: linux-mmc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Greg Kroah-Hartman <greg@kroah.com>
> Cc: Dilan Lee <dilee@nvidia.com>
> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> Cc: Manjunath GKondaiah <manjunath.gkondaiah@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> 
>  include/linux/errno.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/errno.h b/include/linux/errno.h
> index 4668583..83d8fcf 100644
> --- a/include/linux/errno.h
> +++ b/include/linux/errno.h
> @@ -16,6 +16,7 @@
>  #define ERESTARTNOHAND	514	/* restart if no handler.. */
>  #define ENOIOCTLCMD	515	/* No ioctl command */
>  #define ERESTART_RESTARTBLOCK 516 /* restart by calling sys_restart_syscall */
> +#define EPROBE_DEFER	517	/* restart probe again after some time */

Can we really do this?  Isn't this some user/kernel api here?

What's wrong with just "overloading" on top of an existing error code?
Surely one of the other 516 types could be used here, right?

greg k-h
