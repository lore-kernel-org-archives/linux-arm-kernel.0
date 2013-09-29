From: broonie@kernel.org (Mark Brown)
Date: Sun, 29 Sep 2013 13:31:40 +0100
Subject: [PATCH 3/4] spi: davinci: Allow SPI to be build without EDMA
 support
In-Reply-To: <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
 <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130929123140.GU19304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 27, 2013 at 07:42:35PM -0400, Santosh Shilimkar wrote:

> DaVinci SPI IP works without EDMA support and thats how it has
> been used on Keystone SOCs currently. Hence keep the EDMA select
> limited to ARCH_DAVINCI so that Keystone SOCs can use the driver.

> Keystone SOC do support EDMA IP as well but the support has
> not been added and tested so far.

If there's no hard dependency on EDMA then the driver probably ought to
be marked as COMPILE_TEST so that it can be build tested on other
systems.  Is that possible?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130929/ab65c9b9/attachment.sig>
