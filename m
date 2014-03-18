From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 18 Mar 2014 11:23:43 +0100
Subject: [PATCH RESEND 1/2] ARM: ixp4xx: Make dma_set_coherent_mask common,
 correct implementation
In-Reply-To: <20140318090905.72a686e8@marrow.netinsight.se> ("Simon
 =?utf-8?B?S8OlZ3N0csO2bSIncw==?= message of "Tue, 18 Mar 2014 09:09:05
 +0100")
References: <20140317105448.14bcb617@marrow.netinsight.se>
 <20140317105659.449505d8@marrow.netinsight.se>
 <m3iorcj6nb.fsf@t19.piap.pl>
 <20140318090905.72a686e8@marrow.netinsight.se>
Message-ID: <m361nbkdow.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Simon K?gstr?m <simon.kagstrom@netinsight.net> writes:

>> +#ifdef CONFIG_PCI
>
> To me it seems the conditional compilation is superfluous - dev_is_pci
> is used to check for PCI-devices anyway, and the compiler should be
> smart enough to remove dead code for the non-PCI case.

Right.

>> +static int ixp4xx_needs_bounce(struct device *dev, dma_addr_t dma_addr, size_t size)
>> +{
>> +	return (dma_addr + size) >= SZ_64M;
>> +}
>> +
>> +static int ixp4xx_platform_notify_remove(struct device *dev)
>> +{
>> +	if (dev->bus == &pci_bus_type)
>
> if (dev_is_pci(dev))

Sure.
I will finally fix this, but I want it to at least successfully build
and boot on a couple of boards from different makers before I send
anything to be applied.

Just not now :-(
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
