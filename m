From: sophian.yoma@gmail.com (yoma sophian)
Date: Fri, 17 Apr 2015 09:23:11 +0800
Subject: some question about writel implement in arm platform
In-Reply-To: <2505138.CuSGrDpcOa@wuerfel>
References: <CADUS3om64T1pfRqo7nRAVcnj7SKUR2jt4ZsYBcHrgpa7Zb1pkw@mail.gmail.com>
 <3810108.M3CSfEDqyN@wuerfel>
 <CADUS3onDbAJQHnKvVavf_+nYTU1zncEu6pvSZAr=sztqgyZ6wA@mail.gmail.com>
 <2505138.CuSGrDpcOa@wuerfel>
Message-ID: <CADUS3o=0CB_9f2=VcHqmCKzQnujz2yGDvf5Y5oh7cxvbL2Y_Dg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi arnd:

2015-04-16 17:47 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 16 April 2015 16:06:16 yoma sophian wrote:
>>
>> 2015-04-16 14:19 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
>> > On Thursday 16 April 2015 13:28:41 yoma sophian wrote:
>> >> hi all:
>> >> the implementation of writel in ARM is writel_relaxed() with barrier
>> >> before (DSB + outer cache sync).
>> >>
>> >> if the memory is device memory, shall we still need outer cache sync?
>> >
>> > Yes.
>> Take my platform for example, I use Cortex A9 with PL310 L2 cache controller.
>> if the memory is device memory, that mean it is un-cacheable why we
>> still need to out sync off the PL310 buffer in writel operation?
>
> The l2 sync is to ensure that prior memory writes are visible to a DMA
> master that gets triggered by the writel.
>
> If your device is not a DMA master, or the operation is unrelated to
> DMA, you can use writel_relaxed().

Thanks for your kind explanation.
