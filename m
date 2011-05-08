From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Sun, 8 May 2011 17:25:55 +0200
Subject: [PATCH][WAS:bcmai,
	axi] bcma: add Broadcom specific AMBA bus driver
In-Reply-To: <201105081706.12449.arnd@arndb.de>
References: <1304632783-8781-1-git-send-email-zajec5@gmail.com>
	<BANLkTikjr0ZTNOu69F+iKhwufE9KKMg4Tg@mail.gmail.com>
	<BANLkTimGBNT4FkS4mO9ToLWft0bCEYcEgg@mail.gmail.com>
	<201105081706.12449.arnd@arndb.de>
Message-ID: <BANLkTinujj_E4xPvbXB_AQM-d9BqHRts8Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/5/8 Arnd Bergmann <arnd@arndb.de>:
> On Saturday 07 May 2011, Rafa? Mi?ecki wrote:
>> > Well, maybe. We call it only once, at init time. In any case we're
>> > still waiting for Broadcom to clarify which cores are really used for
>> > BCMA.
>>
>> Arnd: did you have a look at defines at all?
>>
>> Most of the defines have values in range 0x800 ? 0x837. Converting
>> this to array means loosing 0x800 u16 entries. We can not use 0x800
>> offset, because there are also some defined between 0x000 and 0x800:
>> #define BCMA_CORE_OOB_ROUTER ? ? ? ? ? 0x367 ? /* Out of band */
>> #define BCMA_CORE_INVALID ? ? ? ? ? ? ?0x700
>
> I did not mean using the enum value as index, just make an array of
> simple structs:
>
> struct bcma_device_name {
> ? ? ? ?unsigned int id;
> ? ? ? ?const char *name;
> };
>
> struct bcma_device_name bcma_device_names = {
> ? ? ? ?{ BCMA_CORE_OOB_ROUTER, "Out of band router" },
> ? ? ? ?{ BCMA_CORE_INVALID, ? ?"Invalid" },
> ? ? ? ?...
> };

Arnd, right now I'm loosing a lot of time (I could spent on improving
bcma or b43) on posting new version of this huge patch with single
changes. Changes that can easily be introduced later without breaking
driver, ABI, etc.

I'll be glad to try your solution later, when we get this patch
merged. I'll be much easier to play with such a differences then.
Thanks for sharing this idea.

Right now I want to focus on some bugs in driver that don't allow it
being merged.

-- 
Rafa?
