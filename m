From: greg@kroah.com (Greg KH)
Date: Mon, 11 Apr 2011 14:07:03 -0700
Subject: [RFC][PATCH V3] axi: add AXI bus driver
In-Reply-To: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
References: <1302557114-7880-1-git-send-email-zajec5@gmail.com>
Message-ID: <20110411210703.GB28559@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 11:25:14PM +0200, Rafa? Mi?ecki wrote:
> Cc: Michael B?sch <mb@bu3sch.de>
> Cc: Larry Finger <Larry.Finger@lwfinger.net>
> Cc: George Kashperko <george@znau.edu.ua>
> Cc: Arend van Spriel <arend@broadcom.com>
> Cc: linux-arm-kernel at lists.infradead.org <linux-arm-kernel@lists.infradead.org>
> Cc: Russell King <rmk@arm.linux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Andy Botting <andy@andybotting.com>
> Cc: linuxdriverproject <devel@linuxdriverproject.org>
> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
> ---
> V2: Rename to axi
>     Use DEFINE_PCI_DEVICE_TABLE in bridge
>     Make use of pr_fmt and pr_*
>     Store core class
>     Rename bridge to not b43 specific
>     Replace magic 0x1000 with BCMAI_CORE_SIZE
>     Remove some old "ssb" names and defines
>     Move BCMAI_ADDR_BASE def
>     Add drvdata field
> V3: Fix reloading (kfree issue)
>     Add 14e4:4331
>     Fix non-initialized struct issue
>     Drop useless inline functions wrappers for pci core drv
>     Proper pr_* usage
>     Helps in Kconfig
> ---
>  drivers/Kconfig                           |    2 +
>  drivers/Makefile                          |    1 +
>  drivers/axi/Kconfig                       |   33 +++
>  drivers/axi/Makefile                      |    7 +
>  drivers/axi/TODO                          |    3 +
>  drivers/axi/axi_pci_bridge.c              |   34 +++
>  drivers/axi/axi_private.h                 |   45 ++++
>  drivers/axi/core.c                        |   52 ++++
>  drivers/axi/driver_chipcommon.c           |   87 +++++++
>  drivers/axi/driver_chipcommon_pmu.c       |  134 ++++++++++
>  drivers/axi/driver_pci.c                  |  167 ++++++++++++
>  drivers/axi/host_pci.c                    |  177 +++++++++++++
>  drivers/axi/main.c                        |  256 +++++++++++++++++++
>  drivers/axi/scan.c                        |  393 +++++++++++++++++++++++++++++
>  drivers/axi/scan.h                        |   56 ++++
>  include/linux/axi/axi.h                   |  221 ++++++++++++++++
>  include/linux/axi/axi_driver_chipcommon.h |  308 ++++++++++++++++++++++
>  include/linux/axi/axi_driver_pci.h        |   89 +++++++
>  include/linux/axi/axi_regs.h              |   34 +++
>  include/linux/mod_devicetable.h           |   17 ++
>  scripts/mod/file2alias.c                  |   21 ++

Where is the documentation files for the new sysfs files you just
created?

thanks,

greg k-h
