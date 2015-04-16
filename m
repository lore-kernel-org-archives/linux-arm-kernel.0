From: sophian.yoma@gmail.com (yoma sophian)
Date: Thu, 16 Apr 2015 16:06:16 +0800
Subject: some question about writel implement in arm platform
In-Reply-To: <3810108.M3CSfEDqyN@wuerfel>
References: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
 <3810108.M3CSfEDqyN@wuerfel>
Message-ID: <CADUS3onDbAJQHnKvVavf_+nYTU1zncEu6pvSZAr=sztqgyZ6wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi arnd:

2015-04-16 14:19 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 16 April 2015 13:28:41 yoma sophian wrote:
>> hi all:
>> the implementation of writel in ARM is writel_relaxed() with barrier
>> before (DSB + outer cache sync).
>>
>> if the memory is device memory, shall we still need outer cache sync?
>
> Yes.
Take my platform for example, I use Cortex A9 with PL310 L2 cache controller.
if the memory is device memory, that mean it is un-cacheable why we
still need to out sync off the PL310 buffer in writel operation?
>
>> if the memory is normal normal, under what circumstance we will write
>> it with writel.
>
> For normal memory, you never use writel.
>
>> As far as I know, the writel is used for register writing.
>
> Correct.
if so, why we need to do PL310 cache sync for those memory that are
not cacheable?

appreciate your kind help,
