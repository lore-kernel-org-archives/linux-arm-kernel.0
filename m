From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Tue, 19 Dec 2017 15:24:58 +0200
Subject: [PATCH V4 14/26] pch_gbe: deprecate pci_get_bus_and_slot()
In-Reply-To: <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
References: <1513661883-28662-1-git-send-email-okaya@codeaurora.org>
 <1513661883-28662-15-git-send-email-okaya@codeaurora.org>
 <1513680330.7000.167.camel@linux.intel.com>
 <ef7d09ce-06af-ad3e-1048-3b413cc32e9b@codeaurora.org>
Message-ID: <1513689898.7000.191.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-12-19 at 07:17 -0500, Sinan Kaya wrote:
> On 12/19/2017 5:45 AM, Andy Shevchenko wrote:
> > On Tue, 2017-12-19 at 00:37 -0500, Sinan Kaya wrote:
> > > 

> > pci_get_bus_and_slot() still might be useful for the wired devices
> > in
> > SoC where we know for sure that domain == 0.
> > 
> 
> Then hard code the domain number as 0 while calling
> pci_get_domain_bus_and_slot()
> if you know for sure that this device will never work on a non-zero
> domain.

Thanks for so detailed explanation.

Okay, I suppose you did estimate the amount of drivers / modules that
may look better with pci_get_bus_and_slot() and the result is comparable
  small.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
