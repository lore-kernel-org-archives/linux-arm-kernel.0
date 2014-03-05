From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Wed, 05 Mar 2014 10:55:02 +0100
Subject: [PATCH 2/2] ixp4xx_eth: Setup coherent_dma_mask
In-Reply-To: <20140305094330.GU21483@n2100.arm.linux.org.uk> (Russell King's
 message of "Wed, 5 Mar 2014 09:43:30 +0000")
References: <20140305085311.07b3922a@marrow.netinsight.se>
 <20140305085549.3eb22236@marrow.netinsight.se>
 <m3d2i1atmq.fsf@t19.piap.pl>
 <20140305094330.GU21483@n2100.arm.linux.org.uk>
Message-ID: <m38uspas21.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

>> > +	err = dma_set_coherent_mask(&dev->dev, DMA_BIT_MASK(32));
>> > +	if (err < 0)
>> > +		goto err_free;
>> > +
>> 
>> Both David and the DMA API say 32 bits must be the default. OTOH there
>> is other code like this in the kernel, guess IXP4xx is not alone with
>> such constrains.
>
> If you have drivers missing this call, that's part of the problem:
>
> | For correct operation, you must interrogate the kernel in your device
> | probe routine to see if the DMA controller on the machine can properly
> | support the DMA addressing limitation your device has.

Well, we already know it can. Actually, the DMA controller is a part of
the CPU + RAM controller chip :-)

But I guess with this new wording it's something the drivers can use.
-- 
Krzysztof Halasa

Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
