From: dingtianhong@huawei.com (Ding Tianhong)
Date: Tue, 20 Jan 2015 10:15:05 +0800
Subject: [PATCH net-next v13 3/3] net: hisilicon: new hip04 ethernet driver
In-Reply-To: <9314032.C8yR0htxiP@wuerfel>
References: <1421217254-12008-1-git-send-email-dingtianhong@huawei.com>
 <1421217254-12008-4-git-send-email-dingtianhong@huawei.com>
 <54BD48BF.3050707@suse.de> <9314032.C8yR0htxiP@wuerfel>
Message-ID: <54BDBA29.10703@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015/1/20 4:34, Arnd Bergmann wrote:
> On Monday 19 January 2015 19:11:11 Alexander Graf wrote:
>>
>> After hammering on the box a bit again, I'm in a situation where I get 
>> lots of
>>
>> [302398.232603] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302398.377309] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302398.395198] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302398.466118] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302398.659009] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.053389] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.122067] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.268192] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.286081] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.594201] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.683416] hip04-ether e28b0000.ethernet eth0: rx drop
>> [302399.701307] hip04-ether e28b0000.ethernet eth0: rx drop
>>
>> and I really am getting a lot of drops - I can't even ping the machine 
>> anymore.
>>
>> However, as it is there's a good chance the machine is simply 
>> unreachable because it's busy writing to the UART, and even if not all 
>> useful messages indicating anything have scrolled out. I really don't 
>> think you should emit any message over and over again to the user. Once 
>> or twice is enough.
>>
>> Please make sure to rate limit it.
> 
> I would argue that packet loss is not an error condition at all
> and you should not print this at netdev_err() level. You could make
> this a netdev_dbg(), or just make it silent because it's already
> counted in the statistics.
> 

I think something wrong with Graf's board, I will try to make it happen on my board, and 
in any case I will add rate limit to xx_drop and change to dbg log level.

Thanks 
Ding

> 	Arnd
> 
> .
> 
