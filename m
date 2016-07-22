From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 22 Jul 2016 15:27:04 +0200
Subject: [RFC PATCH v1 0/2] Add Hisilicon Djtag driver
In-Reply-To: <20160722105648.GD17584@leverpostej>
References: <1469177332-72156-1-git-send-email-tanxiaojun@huawei.com>
 <20160722105648.GD17584@leverpostej>
Message-ID: <11848764.OZ77lJYCM4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, July 22, 2016 11:56:49 AM CEST Mark Rutland wrote:
> Hi,
> 
> I understand that some SoC/socket level PMU is accessed via these
> registers. It doesn't make sense to review either in isolation. Please
> put together a unified series, with both the djtag accessors and the
> PMU code.
> 
> On it's own, it's *very* difficult to understand how this fits into the
> SoC, and how it is to be used.

Is there anything else that the driver is used for?

Having it in drivers/soc/ feels wrong to me, and if there is only
one user, I'd recommend having it as part of the same driver module
as the code accessing it.

	Arnd
