From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 19 Dec 2017 12:45:30 +0200
Subject: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
In-Reply-To: <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
Message-ID: <1513680330.7000.167.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-19 at 00:37 -0500, Sinan Kaya wrote:
> pci_get_bus_and_slot() is restrictive such that it assumes domain=0 as
> where a PCI device is present. This restricts the device drivers to be
> reused for other domain numbers.
> 
> Getting ready to remove pci_get_bus_and_slot() function in favor of
> pci_get_domain_bus_and_slot().
> 

Where this idea come from?

pci_get_bus_and_slot() still might be useful for the wired devices in
SoC where we know for sure that domain == 0.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
