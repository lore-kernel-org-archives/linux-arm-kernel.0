From: mika.westerberg@linux.intel.com (Mika Westerberg)
Date: Fri, 25 Jul 2014 10:11:38 +0300
Subject: [PATCH] spi/pxa2xx-pci: Enable DMA binding through device name
In-Reply-To: <20140724140620.GP1857@lahna.fi.intel.com>
References: <1406196111-22861-1-git-send-email-hock.leong.kweh@intel.com>
 <10365151.12bEvS9Gvj@wuerfel>
 <20140724140620.GP1857@lahna.fi.intel.com>
Message-ID: <20140725071138.GU1857@lahna.fi.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 24, 2014 at 05:06:20PM +0300, Mika Westerberg wrote:
> > On a related note, there seems to be a bug in this driver, which
> > attempts to set the slave_id through dmaengine_slave_config(), which
> > is wrong in both cases, ACPI and filter functions.
> 
> Good point. We will fix this, thanks.

I take that back. How we are supposed to set the slave_id if we don't
have request line information available (from ACPI or DT)?
