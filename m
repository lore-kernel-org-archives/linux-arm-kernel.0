From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Sep 2013 11:23:48 -0400
Subject: [PATCH 3/4] spi: davinci: Allow SPI to be build without EDMA
 support
In-Reply-To: <20130930143848.GB19304@sirena.org.uk>
References: <1380325356-2100-1-git-send-email-santosh.shilimkar@ti.com>
 <1380325356-2100-4-git-send-email-santosh.shilimkar@ti.com>
 <20130929123140.GU19304@sirena.org.uk> <52497E57.5080700@ti.com>
 <20130930143848.GB19304@sirena.org.uk>
Message-ID: <52499784.9040906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 September 2013 10:38 AM, Mark Brown wrote:
> On Mon, Sep 30, 2013 at 09:36:23AM -0400, Santosh Shilimkar wrote:
>> On Sunday 29 September 2013 08:31 AM, Mark Brown wrote:
> 
>>> If there's no hard dependency on EDMA then the driver probably ought to
>>> be marked as COMPILE_TEST so that it can be build tested on other
>>> systems.  Is that possible?
> 
>> EDMA is already getting tested for DAVINCI builds and there are patches
>> coming AMXXXX SOC support. So probably marking it COMPILE_TEST isn't
>> needed since it has been in use already for other SOCs.
> 
> It'd make life easier for general subsystem development if we were able
> to get build coverage without having to build a specific config, even if
> it's never actually going to be run.
> 
So after your comments, I actually checked whether the driver works with
EDMA enabled but no EDMA node/data information from DT for SPI driver.
It seems to work.

So I am going to drop this patch and rather allow the EDMA to be built
for Keystone SOCs as well. Not sure why I didn't looked at this as an
option first place.

Thanks for your comments Mark.

Regards,
Santosh
