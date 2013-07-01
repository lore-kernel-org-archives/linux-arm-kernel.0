From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Mon, 01 Jul 2013 16:11:16 +0400
Subject: [PATCH 1/3] ARM: shmobile: use common platform header for HPB-DMAC
In-Reply-To: <87ehbij4wc.wl%kuninori.morimoto.gx@renesas.com>
References: <201306300243.57180.sergei.shtylyov@cogentembedded.com>
 <201306300245.58486.sergei.shtylyov@cogentembedded.com>
 <87ehbij4wc.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <51D171E4.3080108@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 01-07-2013 8:11, Kuninori Morimoto wrote:

>> From: Max Filippov <max.filippov@cogentembedded.com>

>> Use previously empty <mach/dma.h> to declare HPB-DMA slave IDs.

>> Signed-off-by: Max Filippov <max.filippov@cogentembedded.com>
>> [Sergei: changed the guard macro name, fixed comment, extended copyright.]
>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

>> ---
>>   arch/arm/mach-shmobile/include/mach/dma.h |   25 ++++++++++++++++++++++++-
>>   1 file changed, 24 insertions(+), 1 deletion(-)

>> Index: renesas/arch/arm/mach-shmobile/include/mach/dma.h
>> ===================================================================
>> --- renesas.orig/arch/arm/mach-shmobile/include/mach/dma.h
>> +++ renesas/arch/arm/mach-shmobile/include/mach/dma.h
>> @@ -1 +1,24 @@
>> -/* empty */
>> +/*
>> + * Copyright (C) 2011-2013 Renesas Electronics Corporation
>> + * Copyright (C) 2013 Cogent Embedded, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2
>> + * as published by the Free Software Foundation.
>> + */
>> +
>> +#ifndef __MACH_DMA_H
>> +#define __MACH_DMA_H
>> +
>> +/* HPB-DMA slave IDs */
>> +enum {
>> +	HPBDMA_SLAVE_DUMMY,
>> +	HPBDMA_SLAVE_SDHI0_TX,
>> +	HPBDMA_SLAVE_SDHI0_RX,
>> +	HPBDMA_SLAVE_SSI0_TX_ST,
>> +	HPBDMA_SLAVE_SSI0_TX_MN,
>> +	HPBDMA_SLAVE_SSI1_RX_ST,
>> +	HPBDMA_SLAVE_SSI1_RX_MN,
>> +};

> it should be in r8a7778.h

    It will be shared with R8A7779.

WBR, Sergei
