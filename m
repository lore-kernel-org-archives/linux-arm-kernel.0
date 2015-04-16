From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 16 Apr 2015 10:29:19 +0800
Subject: [PATCH 1/2 RESEND] ARM: prima2: move to use REGMAP APIs for
 rtciobrg
In-Reply-To: <2891950.ACQLuhXHau@wuerfel>
References: <1429012556-14041-1-git-send-email-21cnbao@gmail.com>
 <2891950.ACQLuhXHau@wuerfel>
Message-ID: <CAGsJ_4zohW8m+2OLoye1G3aHxZUPHkynaY2vDf7z+o03QoSiuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2015-04-15 23:37 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Tuesday 14 April 2015 11:55:55 Barry Song wrote:
>> From: Guo Zeng <Guo.Zeng@csr.com>
>>
>> all devices behind rtciobrg needs a special way to access. currently they
>> are using a platform-specific API.
>> this patch moves to REGMAP, then clients can use regmap APIs to read/write.
>> for the moment, old APIs are still kept, once all clients move to regmap,
>> old APIs will be dropped.
>>
>> this patch also does minor clean for comments, authors statement.
>>
>> Signed-off-by: Guo Zeng <Guo.Zeng@csr.com>
>> Signed-off-by: Barry Song <Baohua.Song@csr.com>
>>
>
> I've finally managed to take a look at the two patches.
>
> For this one, the implementation looks ok in principle, though I wonder
> if you would be able to move the code to a more appropriate location,
> possibly drivers/bus, drivers/soc or into the rtc-sirfsoc driver.
>
> What devices specifically are abstracted by the rtciobrg?

devices behind rtc io bridge are abstracted by it. currently, the
users include rtc drivers, system power management and reset logic.
machine-level pm codes like sleep.S and pm.c are using it too.

for the moment, i feel it is better to be in mach-prima2 since it is
still involved in several machine modules.

>
>         Arnd

-barry
