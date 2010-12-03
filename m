From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Fri, 03 Dec 2010 19:17:04 +0100
Subject: [PATCH 1/6] i2c/pxa2xx: Don't touch ISAR on X86
In-Reply-To: <20101203014424.GG24979@trinity.fluff.org>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
	<1291320589-31570-2-git-send-email-bigeasy@linutronix.de>
	<20101203014424.GG24979@trinity.fluff.org>
Message-ID: <4CF93420.9010006@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks wrote:
>> +#ifndef CONFIG_X86
>>  	writel(i2c->slave_addr, _ISAR(i2c));
>> +#endif


> I'd prefer some way of changing based on either the device name (see
> some other drivers which bind on multiple names) to define things such
> as this, as well as possibly changing the register layout.

Okay, I will hide this ISAR access a platform_device_id id.

Do you want me to also change the register access? This would be a
intrusive patch since I would have to touch every readl()/writel() line
in this file.

Sebastian
