From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 09:36:23 -0400
Subject: [PATCH 3/4] spi: davinci: Allow SPI to be build without EDMA
 support
In-Reply-To: <20130929123140.GU19304@sirena.org.uk>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
 <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
 <20130929123140.GU19304@sirena.org.uk>
Message-ID: <52497E57.5080700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 29 September 2013 08:31 AM, Mark Brown wrote:
> On Fri, Sep 27, 2013 at 07:42:35PM -0400, Santosh Shilimkar wrote:
> 
>> DaVinci SPI IP works without EDMA support and thats how it has
>> been used on Keystone SOCs currently. Hence keep the EDMA select
>> limited to ARCH_DAVINCI so that Keystone SOCs can use the driver.
> 
>> Keystone SOC do support EDMA IP as well but the support has
>> not been added and tested so far.
> 
> If there's no hard dependency on EDMA then the driver probably ought to
> be marked as COMPILE_TEST so that it can be build tested on other
> systems.  Is that possible?
> 
EDMA is already getting tested for DAVINCI builds and there are patches
coming AMXXXX SOC support. So probably marking it COMPILE_TEST isn't
needed since it has been in use already for other SOCs.

Regards,
Santosh
