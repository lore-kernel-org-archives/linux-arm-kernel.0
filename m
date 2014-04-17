From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 17 Apr 2014 12:53:03 +0200
Subject: [PATCH 0/5] defconfigs: add MTD_SPI_NOR (dependency for M25P80)
In-Reply-To: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
Message-ID: <20140417105302.GA32603@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 17, 2014 at 12:21:44AM -0700, Brian Norris wrote:
> Hi all,
> 
> We are introducing a new SPI-NOR library/framework for MTD, to support various
> types of SPI-NOR flash controllers which require (or benefit from) intimate
> knowledge of the flash interface, rather than just the relatively dumb SPI
> interface. This library borrows much of the m25p80 driver for its abstraction
> and moves this code into a spi-nor module.

If this is a common library, then the more common approach to solve this
would be to have each driver that uses it to select MTD_SPI_NOR rather
than depend on it. That way you can drop this whole series to update the
default configurations.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140417/d37d6536/attachment-0001.sig>
