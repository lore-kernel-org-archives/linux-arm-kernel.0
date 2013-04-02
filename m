From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Tue, 02 Apr 2013 15:47:18 +0400
Subject: [PATCH 1/2] ARM: shmobile: R8A7779: add Ether support
In-Reply-To: <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
References: <201304020204.54546.sergei.shtylyov@cogentembedded.com>
 <87wqsl6ale.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <515AC546.90905@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 02-04-2013 4:27, Kuninori Morimoto wrote:

>> +void __init r8a7779_add_ether_device(void *pdata)
>> +{
>> +	ether_device.dev.platform_data = pdata;
>> +
>> +	platform_device_register(&ether_device);
>> +}

> We didn't use this style of registration before,
> but, it is OK.

     Se the DU support patches, I'm copying the approach from them.

> Then, this (void *pdata) should be
> (struct sh_eth_plat_data *pdata) IMO

    ether_device.dev.platform_data is 'void *'. I didn't want to bring in 
extra header for the little use.

WBR, Sergei
