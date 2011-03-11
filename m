From: vapier.adi@gmail.com (Mike Frysinger)
Date: Thu, 10 Mar 2011 20:00:54 -0500
Subject: [PATCH] kbuild: reenable section mismatch analysis
In-Reply-To: <20110310164100.5af81e3b.akpm@linux-foundation.org>
References: <20110216200734.GA25184@merkur.ravnborg.org>
	<1298062040-2774-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20110310164100.5af81e3b.akpm@linux-foundation.org>
Message-ID: <AANLkTik7HwLs8Ux=THRy_-ByH4adebHodSLeEgSSqcsH@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/10 Andrew Morton :
> On Fri, 18 Feb 2011 21:47:20 +0100 Uwe Kleine-K__nig wrote:
>> This was disabled in commit
>>
>> ? ? ? e5f95c8 (kbuild: print only total number of section mismatces found)
>>
>> because there were too many warnings. ?Now we're down to a reasonable
>> number again, so we start scaring people with the details.
>>
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -102,11 +102,7 @@ config HEADERS_CHECK
>>
>> ?config DEBUG_SECTION_MISMATCH
>> ? ? ? bool "Enable full Section mismatch analysis"
>> - ? ? depends on UNDEFINED || (BLACKFIN)
>> ? ? ? default y
>> - ? ? # This option is on purpose disabled for now.
>> - ? ? # It will be enabled when we are down to a reasonable number
>> - ? ? # of section mismatch warnings (< 10 for an allyesconfig build)
>> ? ? ? help
>> ? ? ? ? The section mismatch analysis checks if there are illegal
>> ? ? ? ? references from one section to another section.
>
> eaaaargh! ?650 lines of crap added to my i386 allmodconfig build output.

and it's going to keep staying all f-ed up until people start seeing
this stuff themselves when they write the bad code
-mike
