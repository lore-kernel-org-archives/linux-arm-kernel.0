From: jason77.wang@gmail.com (jason)
Date: Wed, 23 Jun 2010 22:54:19 +0800
Subject: [PATCH V2 1/2] mxc: add common debug board for 3-stack	platforms
In-Reply-To: <20100623065914.GO12115@pengutronix.de>
References: <1277216851-15782-1-git-send-email-jason77.wang@gmail.com>
	<1277216851-15782-2-git-send-email-jason77.wang@gmail.com>
	<20100623065914.GO12115@pengutronix.de>
Message-ID: <4C22201B.7080906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer wrote:
> On Tue, Jun 22, 2010 at 10:27:30PM +0800, Jason Wang wrote:
>   
>> The debug board is little different for all mxc 3-stack(PDK)
>> platforms, it is possible here to add a common implementation to
>> support this board.
>>
>> +
>> +void __init mxc_expio_lan_init(void)
>> +{
>> +	platform_device_register(&smsc_lan9217_device);
>> +}
>>     
>
> What do we need this for? Can't we just call this from
> mxc_expio_init()?
>
>
>   
I add this function for lan because on the debugboard there are other 
potential
useful devices(like UART or keys). In future if we add these device 
definitions, we can select
which one will be registered to the system instead of all devices.

Currently only lan device is implemented, it is reasonable to move it to 
mxc_expio_init() and
let them to bind together. I will fix it.

Thanks,
Jason.
