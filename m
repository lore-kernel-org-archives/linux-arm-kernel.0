From: greg@kroah.com (Greg KH)
Date: Mon, 2 May 2011 15:11:21 -0700
Subject: AT91: Move non-portable processor-specific code out of USB
	Gadget drivers
In-Reply-To: <1304373608.1628.19.camel@redbox>
References: <1304373608.1628.19.camel@redbox>
Message-ID: <20110502221121.GB31075@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 03, 2011 at 12:00:08AM +0200, Andrew Victor wrote:
> For supporting multiple AT91 processors in a single kernel image, the
> address of system-peripherals cannot be determined at compile-time.
> Therefore we need to remove calls to the at91_sys_read/at91_sys_write
> macro's and any "#ifdef CONFIG_ARCH_AT91xxx" code.
> 
> In the USB Gadget subsystems there are 2 instances:
>  * controlling the pullup for the AT91SAM9261.
>  * controlling the bias for the AT91SAM9RL.
> 
> The following patch add a "pullup" method to the "struct at91_udc_data"
> platform-data, and a "set_bias" method to the "struct
> usba_platform_data".  The code for the two instances above is moved from
> the drivers and into the processor-specific code.  The driver's access
> the code via the methods provided in the platform_data.
> 
> Signed-off-by: Andrew Victor <linux@maxim.org.za>

Acked-by:
	Greg Kroah-Hartman <gregkh@suse.de>

Feel free to take this through some random ARM tree :)

thanks,

greg k-h
