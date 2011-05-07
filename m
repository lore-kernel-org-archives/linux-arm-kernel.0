From: hauke@hauke-m.de (Hauke Mehrtens)
Date: Sat, 07 May 2011 18:32:37 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <BANLkTi=FfjK7obq0hj4TjYZc-GgzTuUC6g@mail.gmail.com>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>	<4DC56FB9.5000208@hauke-m.de>
	<BANLkTi=FfjK7obq0hj4TjYZc-GgzTuUC6g@mail.gmail.com>
Message-ID: <4DC57425.30206@hauke-m.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/07/2011 06:23 PM, Rafa? Mi?ecki wrote:
> 2011/5/7 Hauke Mehrtens <hauke@hauke-m.de>:
>> On 05/05/2011 11:59 PM, Rafa? Mi?ecki wrote:
>>> Cc: Greg KH <greg@kroah.com>
>>> Cc: Michael B?sch <mb@bu3sch.de>
>>> Cc: Larry Finger <Larry.Finger@lwfinger.net>
>>> Cc: George Kashperko <george@znau.edu.ua>
>>> Cc: Arend van Spriel <arend@broadcom.com>
>>> Cc: linux-arm-kernel at lists.infradead.org
>>> Cc: Russell King <rmk@arm.linux.org.uk>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Andy Botting <andy@andybotting.com>
>>> Cc: linuxdriverproject <devel@linuxdriverproject.org>
>>> Cc: linux-kernel at vger.kernel.org <linux-kernel@vger.kernel.org>
>>> Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
>>> ---
>>> V2: Rename to axi
>>>     Use DEFINE_PCI_DEVICE_TABLE in bridge
>>>     Make use of pr_fmt and pr_*
>>>     Store core class
>>>     Rename bridge to not b43 specific
>>>     Replace magic 0x1000 with BCMAI_CORE_SIZE
>>>     Remove some old "ssb" names and defines
>>>     Move BCMAI_ADDR_BASE def
>>>     Add drvdata field
>>> V3: Fix reloading (kfree issue)
>>>     Add 14e4:0x4331
>>>     Fix non-initialized struct issue
>>>     Drop useless inline functions wrappers for pci core drv
>>>     Proper pr_* usage
>>> V3.1: Include forgotten changes (pr_* and include related)
>>>     Explain why we dare to implement empty release function
>>> V4: Add ABI documentation
>>>     Move struct device to wrapper and alloc it dynamically
>>>     checkpatch.pl pointed fixes
>>> V5: Rename to bcma, AXI was really bad name
>>>     Use EXPORT_SYMBOL_GPL
>>>     Set pci driver fields in one place
>>>     Drop unlikely
>>>     Use BCMA_CORE_SIZE for calc in awrite32
>>>     Add README
>>>     Fix compilation (delay.h)
>>> ---
>>>  Documentation/ABI/testing/sysfs-bus-bcma    |   31 ++
>>>  drivers/Kconfig                             |    2 +
>>>  drivers/Makefile                            |    1 +
>>>  drivers/bcma/Kconfig                        |   33 +++
>>>  drivers/bcma/Makefile                       |    7 +
>>>  drivers/bcma/README                         |   18 ++
>>>  drivers/bcma/TODO                           |    3 +
>>>  drivers/bcma/bcma_private.h                 |   31 ++
>>>  drivers/bcma/core.c                         |   51 ++++
>>>  drivers/bcma/driver_chipcommon.c            |   87 ++++++
>>>  drivers/bcma/driver_chipcommon_pmu.c        |  134 +++++++++
>>>  drivers/bcma/driver_pci.c                   |  163 +++++++++++
>>>  drivers/bcma/host_pci.c                     |  196 +++++++++++++
>>>  drivers/bcma/main.c                         |  271 ++++++++++++++++++
>>>  drivers/bcma/scan.c                         |  392 +++++++++++++++++++++++++++
>>>  drivers/bcma/scan.h                         |   56 ++++
>>>  include/linux/bcma/bcma.h                   |  232 ++++++++++++++++
>>>  include/linux/bcma/bcma_driver_chipcommon.h |  297 ++++++++++++++++++++
>>>  include/linux/bcma/bcma_driver_pci.h        |   89 ++++++
>>>  include/linux/bcma/bcma_regs.h              |   34 +++
>>>  include/linux/mod_devicetable.h             |   17 ++
>>>  scripts/mod/file2alias.c                    |   22 ++
>>>  22 files changed, 2167 insertions(+), 0 deletions(-)
>>>  create mode 100644 Documentation/ABI/testing/sysfs-bus-bcma
>>>  create mode 100644 drivers/bcma/Kconfig
>>>  create mode 100644 drivers/bcma/Makefile
>>>  create mode 100644 drivers/bcma/README
>>>  create mode 100644 drivers/bcma/TODO
>>>  create mode 100644 drivers/bcma/bcma_private.h
>>>  create mode 100644 drivers/bcma/core.c
>>>  create mode 100644 drivers/bcma/driver_chipcommon.c
>>>  create mode 100644 drivers/bcma/driver_chipcommon_pmu.c
>>>  create mode 100644 drivers/bcma/driver_pci.c
>>>  create mode 100644 drivers/bcma/host_pci.c
>>>  create mode 100644 drivers/bcma/main.c
>>>  create mode 100644 drivers/bcma/scan.c
>>>  create mode 100644 drivers/bcma/scan.h
>>>  create mode 100644 include/linux/bcma/bcma.h
>>>  create mode 100644 include/linux/bcma/bcma_driver_chipcommon.h
>>>  create mode 100644 include/linux/bcma/bcma_driver_pci.h
>>>  create mode 100644 include/linux/bcma/bcma_regs.h
>>>
>> Hi,
>>
>> An entry in the MAINTAINERS file would be nice to find the right
>> addresses to send patches to.
> 
> Will do, thanks. Should I put some ML for this driver?
> netdev at vger.kernel.org? linux-wireless at vger.kernel.org? So far there
> are no net drivers for BCMA. Probably b43 will be the first (or
> brcm80211).
> 
There is a Ethernet core used on embedded devices with this bus and
George wrote a driver for the first version of this bus implementation,
he send to the ML. Most user will use this with some wireless devices so
I would add linux-wireless at vger.kernel.org. Why does ssb uses netdev ML?

Hauke
