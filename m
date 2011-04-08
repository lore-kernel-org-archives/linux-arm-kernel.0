From: greg@kroah.com (Greg KH)
Date: Fri, 8 Apr 2011 15:01:57 -0700
Subject: [RFC][WAS:bcmai][PATCH V2] axi: add AXI bus driver
In-Reply-To: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
References: <1302291900-1902-1-git-send-email-zajec5@gmail.com>
Message-ID: <20110408220157.GC26019@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2011 at 09:45:00PM +0200, Rafa? Mi?ecki wrote:
> Cc: Michael B?sch <mb@bu3sch.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: George Kashperko <george@znau.edu.ua>
> Cc: Arend van Spriel <arend@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linuxdriverproject <devel@linuxdriverproject.org>
> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> This is second try for introducing new bus driver.
> V2: Rename to axi
>     Use DEFINE_PCI_DEVICE_TABLE in bridge
>     Make use of pr_fmt and pr_*
>     Store core class
>     Rename bridge to not b43 specific
>     Replace magic 0x1000 with BCMAI_CORE_SIZE
>     Remove some old "ssb" names and defines
>     Move BCMAI_ADDR_BASE def
>     Add drvdata field
> TODO:
> - Interrupts
> - Reloading driver

Please add to the TODO list:
	- Documentation/ABI entries for new sysfs files
	- proper Kconfig entry documentation for the different options
	- remove unneeded pcicore_write* wrapper functions that do
	  nothing.


> +static void axi_release_core_dev(struct device *dev)
> +{
> +	kfree(dev);
> +}

This is wrong, unless you are really only creating a 'struct device'.
Why are you doing that instead of embedding struct device in your
structure?

thanks,

greg k-h
