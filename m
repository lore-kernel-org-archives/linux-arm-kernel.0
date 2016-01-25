From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 25 Jan 2016 11:07:32 +0900
Subject: [PATCH] ARM: pxa: let PXA27x select PINCTRL
In-Reply-To: <2718527.DDjjtjgllW@wuerfel>
References: <1453577004-15295-1-git-send-email-yamada.masahiro@socionext.com>
 <1495788.v3fMfHFcmP@wuerfel> <87zivuaf0w.fsf@belgarion.home>
 <2718527.DDjjtjgllW@wuerfel>
Message-ID: <CAK7LNATMuMHRfeYAJ9jwMrsnFOxxGdegcAGB40k=M611gZOZUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robert,

2016-01-25 6:33 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Sunday 24 January 2016 21:39:11 Robert Jarzmik wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>> > On Saturday 23 January 2016 23:07:44 Robert Jarzmik wrote:
>> >> I have this patch in my local tree for 2 monthes (see [1]). This is the patch
>> >> I'd rather have. I had not posted it as I didn't think the pinctrl work was over
>> >> yet. I know at least that pxa3xx is ready (as pinctrl-single should be used),
>> >> and I had not the time to create the map for pxa25x.
>> >
>> > Once you are done, does that mean the plat-pxa/mfp.c stuff becomes
>> > completely unused on pxa, or will it coexist with pinctrl?
>> At first it will coexist.
>> The main blocker so far I have are :
>>  - the pinconf in platform_data platform to define sleep state pin levels
>>    (aka. MFPR_LPM_DRIVE_LOW and MFPR_LPM_DRIVE_HIGH)
>>    I have [1], but it's not working yet, ie. upon entering suspend to RAM, the
>>    GPIO sleep registers are not programmed as expected.
>>  - all the pxa machine code have to be migrated from MFP to pinctrl
>>
>> So it will take time.
>
> Ok.
>
>> > I'm asking because it seems that at that point, the entire plat-pxa
>> > directory can be removed, with the dma.c and ssp.c files getting
>> > moved to mach-pxa, and mfp.c moved to mach-mmp. :-)
>> dma.c will die soon enough anyway, ssp.c will move to mach-pxa indeed, and as
>> for mfp.c it requires a bit of work.
>
> Sounds good.
>


It's OK if you will this later.
Just disregard mine.




-- 
Best Regards
Masahiro Yamada
