From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 6 Jul 2010 10:09:23 +0800
Subject: [PATCH 11/11] Auto calculate ZRELADDR and provide option for
	exceptions
In-Reply-To: <alpine.LFD.2.00.1007051128300.6020@xanadu.home>
References: <20100705141344.GA25407@pengutronix.de>
	<1278339329-23739-11-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.00.1007051128300.6020@xanadu.home>
Message-ID: <AANLkTilyVi1ieW8uKvn4b5V80pP1jZ-WeiOruRIIL829@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/7/5 Nicolas Pitre <nico@fluxnic.net>:
> On Mon, 5 Jul 2010, Uwe Kleine-K?nig wrote:
>
>> From: Eric Miao <eric.miao@canonical.com>
>>
>> As long as the zImage is placed within the 128MB range from the start of
>> memory, ZRELADDR (Address where the decompressed kernel will be placed,
>> usually == PHYS_OFFSET + TEXT_OFFSET) can be determined at run-time by
>> masking PC with 0xf80000000.
>>
>> Running through all the Makefile.boot, all those zreladdr-y
>> addresses == 0x[0-f][08]00_0000 + TEXT_OFFSET can be determined at
>> run-time.
>>
>> Option CONFIG_AUTO_ZRELADDR and CONFIG_ZRELADDR are introduced,
>> CONFIG_ZRELADDR _must_ be explicitly specified if:
>>
>> - ((zreladdr-y - TEXT_OFFSET) & ~0xf8000000) != 0, which means
>> ? masking PC with 0xf8000000 will result in an incorrect address.
>> ? Currently this is only a problem on u300.
>>
>> - or the assumption of the zImage being loaded by the bootloader within
>> ? the first 128MB of RAM is incorrect
>>
>> - or when ZBOOT_ROM is used, where the above assumption is usually wrong.
>>
>> [ukleinek: changed mask from 0xf0000000 to 0xf8000000 for mx1 and shark
>> + some review fixes from the mailing list]
>>
>> Signed-off-by: Eric Miao <eric.miao@canonical.com>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
>
> Although Eric did all the work, the original idea was mine. ?Therefore:
>
> Signed-off-by: Nicolas Pitre <nicolas.pitre@linaro.org>
>

Yep. Uwe, please add this, thanks.
