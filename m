From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 17 Apr 2014 23:30:54 -0700
Subject: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
In-Reply-To: <20140417105302.GA32603@ulmo>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
 <20140417105302.GA32603@ulmo>
Message-ID: <20140418063054.GK5512@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Apr 17, 2014 at 12:53:03PM +0200, Thierry Reding wrote:
> On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> > We are introducing a new SPI-NOR library/framework for MTD, to support various
> > types of SPI-NOR flash controllers which require (or benefit from) intimate
> > knowledge of the flash interface, rather than just the relatively dumb SPI
> > interface. This library borrows much of the m25p80 driver for its abstraction
> > and moves this code into a spi-nor module.
> 
> If this is a common library, then the more common approach to solve this
> would be to have each driver that uses it to select MTD_SPI_NOR rather
> than depend on it. That way you can drop this whole series to update the
> default configurations.

But does MTD_SPI_NOR (and drivers/mtd/spi-nor/) qualify as a "library"
or as a "subsystem"? I thought the latter were typically expected to be
user-selectable options, not automatically-"select"ed.

I would say that, except for its age, MTD_SPI_NOR is very similar in to
MTD_NAND (driver/mtd/nand/), which I'd consider a kind of subsystem, and
which users must select before they are asked about drivers which fall
under its category.

Perhaps my usage of the word "library" in the description was a mistake,
as I don't exactly consider it like a library in the sense of many other
"select"ed libraries.

Brian
