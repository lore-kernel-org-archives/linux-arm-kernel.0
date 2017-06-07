From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Wed, 7 Jun 2017 16:42:32 +0200
Subject: [PATCH 7/9] net: mvmdio: add xmdio support
In-Reply-To: <20170607121205.GC1271@lunn.ch>
References: <20170607083810.30922-1-antoine.tenart@free-electrons.com>
 <20170607083810.30922-8-antoine.tenart@free-electrons.com>
 <20170607121205.GC1271@lunn.ch>
Message-ID: <20170607144232.GA4173@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Wed, Jun 07, 2017 at 02:12:05PM +0200, Andrew Lunn wrote:
> On Wed, Jun 07, 2017 at 10:38:08AM +0200, Antoine Tenart wrote:
> > This patch adds the xMDIO interface support in the mvmdio driver. This
> > interface is used in Ethernet controllers on Marvell 370, 7k and 8k (as
> > of now). The xSMI interface supported by this driver complies with the
> > IEEE 802.3 clause 45 (while the SMI interface complies with the clause
> > 22). The xSMI interface is used by 10GbE devices.
> 
> I've only take a quick look, but i don't see anywhere you look at the
> register address and see if it has MII_ADDR_C45 to determine if a C45
> transaction should be done, or a C22. The MDIO bus can have a mix of
> C45 and C22 devices on it, and you need to use the correct transaction
> type depending on the target device/address.

So this could be dynamic and not based on the compatible. I'll try this
and see if it can work.

Thanks!

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170607/a008eb2c/attachment.sig>
