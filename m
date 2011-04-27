From: subhasish@mistralsolutions.com (Subhasish Ghosh)
Date: Wed, 27 Apr 2011 18:45:06 +0530
Subject: [PATCH v4 08/11] tty: add pruss SUART driver
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024CBA9959@dbde02.ent.ti.com>
References: <1303474109-6212-1-git-send-email-subhasish@mistralsolutions.com>
	<1303474109-6212-9-git-send-email-subhasish@mistralsolutions.com>
	<20110425212056.GA29313@kroah.com>
	<B85A65D85D7EB246BE421B3FB0FBB593024CAE36A6@dbde02.ent.ti.com>
	<20110426124519.GC5977@suse.de>
	<35F38DB5B5C4408EA80AF0DB8A6FA178@subhasishg>
	<B85A65D85D7EB246BE421B3FB0FBB593024CBA9959@dbde02.ent.ti.com>
Message-ID: <F6E90395B84D4E9FA9497247841035FC@subhasishg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 >> >>The driver should probably just get sram
>> >> space through platform data so that it doesn't depend on the
>> >> platform specific sram allocation function.
>>
>> Are you suggesting that I go back to that implementation.
>
> No, the platform code should use the SRAM allocator and
> pass on the allocated memory to the driver.

SG - So, should I call the sram_alloc() in the platform setup function. 
Something like this:

suart_probe() {
...
pdata.setup(&sram_aadr);
...use sram data;
}

suart_remove() {
...
pdata.free(&sram_aadr);
...
} 
