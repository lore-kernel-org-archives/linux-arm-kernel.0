From: bhuvanchandra.dv@toradex.com (BhuvanChandra.DV)
Date: Thu, 29 Jan 2015 11:58:25 +0000
Subject: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
In-Reply-To: <20150128190342.GE21293@sirena.org.uk>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk>
Message-ID: <1422533049999.91114@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/29/2015 12:33 AM, Mark Brown wrote:
> On Tue, Jan 27, 2015 at 04:33:28PM +0530, Bhuvanchandra DV wrote:
>
>> TCFQ is interrupt of Transfer Complete Flag in DSPI module.
>> EOQ is interrupt of End of Queue Flag in DSPI module.
>> For adopting of different platform, either of them is a way of DSPI
>> transfer data. This patch add TCF support for DSPI module  in other platform.
> I can't really understand what the purpose of this is, sorry.  What are
> these modes and why would one choose one over the other?  Your changelog
> suggests this is being done per board which implies that it's tuning for
> performance but that's usually something that should be done in device
> drivers, not the device tree - perhaps the tuning will change over time
> as the driver is optimized or perhaps it varies depending on the
> transfer.
>
> The code mentions a DMA option as well, generally where it's available
> DMA is something that's chosen at runtime based on the length of the
> transfer.

As far as i understood the major difference between the two modes are when
the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
queue and TCF will trigger the interrupt at every frame transfer. Probably
mode selection shouldn't be a device tree property, but i don't see any
automatic way to choose between the modes.
Maybe a config would be more appropriate?

@Chao, is there any specific reason to implement this mode?
