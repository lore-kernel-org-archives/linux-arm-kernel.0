From: salil.mehta@huawei.com (Salil Mehta)
Date: Wed, 6 Jan 2016 15:35:46 +0000
Subject: [PATCH] net: hns: avoid uninitialized variable warning:
In-Reply-To: <20160105.164320.2255971055498857833.davem@davemloft.net>
References: <6649249.INrAY8KJG0@wuerfel>
 <20160105.164320.2255971055498857833.davem@davemloft.net>
Message-ID: <568D3452.80508@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 1/5/2016 9:43 PM, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Fri, 01 Jan 2016 23:27:57 +0100
>
>> gcc fails to see that the use of the 'last_offset' variable
>> in hns_nic_reuse_page() is used correctly and issues a bogus
>> warning:
>>
>> drivers/net/ethernet/hisilicon/hns/hns_enet.c: In function 'hns_nic_reuse_page':
>> drivers/net/ethernet/hisilicon/hns/hns_enet.c:541:6: warning: 'last_offset' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>
>> This simplifies the function to make it more obvious what is
>> going on to both readers and compilers, which makes the warning
>> go away.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>> Compile-tested only, and complex enough that this requires a proper
>> review and testing before it gets apply. Please have a look at this.
> If this goes yet another day without being reviewed, I'm just applying
> it.
>
> You hisilicon folks can't just let patches rot, you must review them
> in a timely manner or else I'm applying them without waiting for you
> to look at them.
Hi David and Arnd,
Apologies for the delay in response and the review. Most of us were on 
the Annual Holidays and have just returned back.

Change looks good to me!

Best Regards
Salil
