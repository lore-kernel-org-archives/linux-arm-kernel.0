From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 25 Jun 2016 13:39:59 -0700
Subject: [PATCH 4/4] tty/serial: atmel: enforce tasklet init and
 termination sequences
In-Reply-To: <5a52e1fbd8ec126bebfcd00f35bfe5af605ee914.1466157015.git.nicolas.ferre@atmel.com>
References: <cover.1466157015.git.nicolas.ferre@atmel.com>
 <5a52e1fbd8ec126bebfcd00f35bfe5af605ee914.1466157015.git.nicolas.ferre@atmel.com>
Message-ID: <20160625203959.GA22761@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2016 at 12:05:49PM +0200, Nicolas Ferre wrote:
> As some race conditions are identified in the termination process of tasklets,
> enforce the atmel_shutdown() sequence. This way we make sure that no new
> tasklets or software timer are scheduled during shutdown process.
> 
> An atomic flag is positioned to give this information throughout the code.
> 
> We also remove tasklet_disable() calls that were leading to deadlocks while
> stopping the driver. A simpler init/kill sequence is used.
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/tty/serial/atmel_serial.c | 61 ++++++++++++++++++++++++---------------
>  1 file changed, 38 insertions(+), 23 deletions(-)

You obviously didn't even test build this patch, as it breaks the build :(

please be more careful...

greg k-h
