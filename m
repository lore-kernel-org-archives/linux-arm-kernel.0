From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Wed, 05 Jan 2011 18:26:21 +0100
Subject: [PATCH 3/6] i2c/pxa2xx: Add PCI support for PXA I2C controller
In-Reply-To: <201012141535.30589.ffainelli@freebox.fr>
References: <1291320589-31570-1-git-send-email-bigeasy@linutronix.de>
	<1291320589-31570-4-git-send-email-bigeasy@linutronix.de>
	<201012141535.30589.ffainelli@freebox.fr>
Message-ID: <4D24A9BD.6010200@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian Fainelli wrote:
>> diff --git a/drivers/i2c/busses/i2c-pxa-pci.c
>> b/drivers/i2c/busses/i2c-pxa-pci.c new file mode 100644
>> index 0000000..f7b74b9
>> --- /dev/null
>> +++ b/drivers/i2c/busses/i2c-pxa-pci.c
>> +
>> +/*
>> + * the number of bars is hardcoded because pci_select_bars() reports the
>> + * wrong thing.
>> + */
>> +#define CE4100_PCI_I2C_DEVS	3
> 
> I am surprised of your comment about pci_select_bars, it works fine here on a 
> CE4100 device, beware that it will report a bitmask of valid resources (7).
> 
> Changing it later would be quite simple anyway.

yep, my bad. I removed the comment and we can make it fully dynamic once
it is required.

Sebastian
