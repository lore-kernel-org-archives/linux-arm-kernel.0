From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Apr 2016 17:31:14 +0200
Subject: [PATCH v2] arm64: pci: add support for pci_mmap_page_range
In-Reply-To: <20160418152126.GA3154@localhost.localdomain>
References: <1460581856-12380-1-git-send-email-jerin.jacob@caviumnetworks.com>
 <29393988.imklgXkpJX@wuerfel> <20160418152126.GA3154@localhost.localdomain>
Message-ID: <4342694.H5cy8vaG9k@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 April 2016 20:51:27 Jerin Jacob wrote:
> 
> Why only to disable mmap() serivce in proc/bus/pci/*/*. Why not
> other  services offered though proc/bus/pci/ like config space read,
> /proc/bus/pci/devices etc
> 
> if a given platform not interested in proc fs  then disable through
> CONFIG_PROC_FS in defconfig. I don't understand the logic behind
> disabling partial services that proc fs exposes.

Disabling CONFIG_PROC_FS is not really an option for anybody.

The config space access may be something we should have disabled,
or it may not be, but I think it's too late to kill that off now,
as that would likely break something.

The mmap() support on those files is way uglier than the config
access, so as long as nobody absolutely requires it, we should
not add it to the list of things we can't get rid of again.

	Arnd
