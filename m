From: tudor.ambarus@microchip.com (Tudor Ambarus)
Date: Tue, 26 Jun 2018 17:44:26 +0300
Subject: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20180622093905.62a3b936@bbrezillon>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
 <20180618162124.21749-2-bugalski.piotr@gmail.com>
 <20180621233321.0f25f572@bbrezillon>
 <alpine.DEB.2.20.1806220719190.21824@carbonite>
 <20180622093905.62a3b936@bbrezillon>
Message-ID: <455adb76-530a-1fd5-303c-cfa158ad7870@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Piotr,

General things to consider for the limitation in performance:
- is the serial flash memory operating in Quad SPI?
- QSCLK should be as high as possible
- transfer delays - I checked them, they have default values, we should be good.
- use DMA, as you suggested

On 06/22/2018 10:39 AM, Boris Brezillon wrote:
> [...]
> 
>>>> +/*
>>>> + * Atmel SAMA5D2 QuadSPI driver.
>>>> + *
>>>> + * Copyright (C) 2018 Cryptera A/S  
>>>
>>> A non-negligible portion of this code has been copied from the existing
>>> driver. Please keep the existing copyright (you can still add Cryptera's
>>> one).
>>>  
>>
>> Technically this driver were written from scratch, with spi-fsl-qspi
>> as example of new interface. Hence the name and code structure.
>> But it's the same peripheral as Atmel's driver uses so code looks
>> similar. I can unify the code to make comparsion even simpler and
>> then update copyright.
> 
> Hm, ok. Some constructs really looked like they were copied
> from the old driver, hence my comment. I'll let Nicolas give his
> opinion on this aspect.

This driver will be a conversion of the legacy one to the spi-mem interface. I
would keep the legacy copyright and add Cryptera's below, as Boris suggested.

[...]

>>>> +#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)  
>>>
>>> Do you really to wait for both INSTRE and CSR to consider the command
>>> as complete?
>>>  
>>
>> This part were really copied from Atmel driver. I wasn't sure so I
>> used tested solution.
> 
> Okay. I guess that's a question for Cyrille and/or Tudor then.

We have to wait for both INSTRE and CSR.

Best,
ta
