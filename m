From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Wed, 30 Nov 2016 22:27:47 +0100
Subject: [PATCH v4 net-next 3/7] net: mvneta: Use cacheable memory to
 store the rx buffer virtual address
In-Reply-To: <20161130.135725.407314756675613303.davem@davemloft.net> (David
 Miller's message of "Wed, 30 Nov 2016 13:57:25 -0500 (EST)")
References: <cover.654978388d6811b943dd58ecb9a9d9b6cceeaee3.1480431285.git-series.gregory.clement@free-electrons.com>
 <cover.654978388d6811b943dd58ecb9a9d9b6cceeaee3.1480431285.git-series.gregory.clement@free-electrons.com>
 <bb2f1a61e9b912905f8390f7a06c36f9f1e7ab66.1480431285.git-series.gregory.clement@free-electrons.com>
 <20161130.135725.407314756675613303.davem@davemloft.net>
Message-ID: <87k2bklkto.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,
 
 On mer., nov. 30 2016, David Miller <davem@davemloft.net> wrote:

> From: Gregory CLEMENT <gregory.clement@free-electrons.com>
> Date: Tue, 29 Nov 2016 15:55:21 +0100
>
>> +	/* Virtual address of the RX buffer */
>> +	void  **buf_virt_addr;
>> +
>>  	/* Virtual address of the RX DMA descriptors array */
>>  	struct mvneta_rx_desc *descs;
>>  
>  ...
>> +		data = (unsigned char *)rxq->buf_virt_addr[index];
>
> This cast is unnecessary, please remove it.

OK I am doing it now.

Thanks,

Gregory


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
