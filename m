From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 2 Sep 2009 22:38:30 -0500
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902231839.GC32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<20090902161252.GD2367@trinity.fluff.org>
	<20090902231839.GC32606@prithivi.gnumonks.org>
Message-ID: <2accc2ff0909022038t64c08d3dodb21dc4ff1f2915b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2009 at 6:18 PM, Harald Welte<laforge@gnumonks.org> wrote:
(cut)
>> > === adc / touchscreen ===
>> > * move plat-s3c24xx/adc.c to plat-s3c/adc.c
>>
>> I belive this patch has already been submitted to the list, but not
>> sorted out.
>
> Is there any particular reason? ?I have looked at the register level
> description of 2410,2440,2443 and 6410... they're 99.9% compatible, so it
> should definitely move out of there. ?I also think the s5pc1xx stuff does
> again have the same IP core for ADC/TS.
>
>> > * update it with 6410 specific ADC extensions (12bit, faster clock, ...)
>> > * port existing s3c_ts driver to use s3c_adc_register()
>> > ** has anyone been doing wokr on this already? ben?
>>
>> I have been keeping Arnaud's drviver up to date with mainline for Simtec,
>> but as such we've not tried submitting this as there is at least one more
>> driver out there (see touchscreen filters which has been already posted
>> to this thread).
>
> Yes, and as Nelson has pointed out, the ts_filters are more controversial
> and should go in separate. ?Can you please get your touchscreen driver
> scheduled for merge? ?If you have known issues, I can help with them, if
> I have the code and know about the issues.

Filtering is not actually merged in the same TS driver. We could
replace it with some basic averaging with little effort. We improved
interrupt handling and avoided jittering with pen-down/pen-up events.
I know it works but I'm sure some cleanup might be needed (perhaps
beyond my knowledge) to make it suitable for upstream.

If it helps I can send a simplified version of the driver that does
not depend on filtering.
Since we don't know Ben's version of the driver then I guess it's Ben's call.

Regards.
