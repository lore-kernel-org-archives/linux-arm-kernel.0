From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 26 Nov 2010 19:28:32 +0100
Subject: [sodaville] [PATCH 1/7] i2c/pxa2xx: Don't touch ISAR if not in
	slave mode
In-Reply-To: <20101125235255.GB15948@trinity.fluff.org>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>	<1290633617-15311-2-git-send-email-bigeasy@linutronix.de>
	<20101125235255.GB15948@trinity.fluff.org>
Message-ID: <4CEFFC50.4090702@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
>> +#ifdef CONFIG_I2C_PXA_SLAVE
>>  	writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif
> 
> I was thinking about whether to add a flag to this to say whether the
> slave_addr field is valid, but to keep full compatiblity with the existing
> pxa users, we'd have to go and change every board using it.

i2c->slave_addr is 1 if slave mode is not enabled. Why should this value
be used in master mode?

Sebastian
