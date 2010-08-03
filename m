From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 3 Aug 2010 15:47:31 +0800
Subject: [PATCHv2] fix Thumb-2 decompressor broken by "Auto calculate
	ZRELADDR"
In-Reply-To: <20100803073627.GA17297@pengutronix.de>
References: <20100731125009.GA15412@pengutronix.de>
	<1280796006-32028-1-git-send-email-rabin@rab.in>
	<20100803073627.GA17297@pengutronix.de>
Message-ID: <AANLkTin4+OD8mLG1sqrDUSdct5ss8EHsSj_CR7gx8V06@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/8/3 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> Hello Rabin,
>
> On Tue, Aug 03, 2010 at 06:10:06AM +0530, Rabin Vincent wrote:
>> "ARM: Auto calculate ZRELADDR and provide option for exceptions" broke
>> the Thumb-2 decompressor because it removed an entry in the LC0 table
>> but didn't adjust the offset the Thumb-2 code uses to load the SP from
>> that table.
>>
>> Fix it, and also change the ARM code to use the separate SP-load since
>> ARM instructions that include the SP in the LDM register list are
>> deprecated.
>>
>> Signed-off-by: Rabin Vincent <rabin@rab.in>
> Acked-and-regretted-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Nah, I seemed to introduce that so you don't have to feel regret :-)
