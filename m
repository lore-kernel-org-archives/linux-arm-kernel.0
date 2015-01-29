From: bhuvanchandra.dv@toradex.com (BhuvanChandra.DV)
Date: Thu, 29 Jan 2015 12:53:57 +0000
Subject: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
In-Reply-To: <20150129121320.GI21293@sirena.org.uk>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk> <1422533049999.91114@toradex.com>
 <20150129121320.GI21293@sirena.org.uk>
Message-ID: <1422536382672.21760@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 01/29/2015 05:43 PM, Mark Brown wrote:
> On Thu, Jan 29, 2015 at 11:58:25AM +0000, BhuvanChandra.DV wrote:
>
>> As far as i understood the major difference between the two modes are when
>> the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
>> queue and TCF will trigger the interrupt at every frame transfer. Probably
>> mode selection shouldn't be a device tree property, but i don't see any
>> automatic way to choose between the modes.
>> Maybe a config would be more appropriate?
> Or if there's either no particular reason to choose one over the other
> or one is always better then just pick one in the driver and don't worry
> about implementing both.

Among the two, EOQ would be better since with TCF, interrupts are generated at
every frame transfer, which could be a problem at higher frequencies.
I think we can omit this patch then.
