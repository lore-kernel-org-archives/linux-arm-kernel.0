From: arhuaco@freaks-unidos.net (Nelson Castillo)
Date: Wed, 2 Sep 2009 10:58:49 -0500
Subject: Samsung S3C6410 mainline merge coordination
In-Reply-To: <20090902121559.GV32606@prithivi.gnumonks.org>
References: <20090902031719.GK3838@prithivi.gnumonks.org>
	<2accc2ff0909020251u4f242742k13aa74f03251b992@mail.gmail.com>
	<20090902121559.GV32606@prithivi.gnumonks.org>
Message-ID: <2accc2ff0909020858k268ab100ve2721730316288e7@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 2, 2009 at 7:15 AM, Harald Welte<laforge@gnumonks.org> wrote:
> Hi Nelson,
>
> On Wed, Sep 02, 2009 at 04:51:56AM -0500, Nelson Castillo wrote:
>> > * port existing s3c_ts driver to use s3c_adc_register()
>> > ** has anyone been doing wokr on this already? ben?
>>
>> (jumping in)
>>
>> I worked on this starting from some work done by other members of this
>> list. This is the ported version of the driver. It depends on the
>> touchscreen filters developed by Andy Green and enhanced by me while
>> working at Openmoko. I've already applied most of Andrew Morton's
>> feedback (a lot) to the TS filters but I haven't submitted them again
>> for upstream review (A filter still needs to be modified and I know
>> how to do it but I haven't finished this change).
>
> Hi, thanks for your feedback. ?I think it is somewhat "dangerous" to create a
> dependency from s3c2410_ts (which schould be renamed to s3c_ts by now) to the
> ts_filter work.
>
> I'd personally prefer to decouple those two, i.e. first submit the s3c_ts based
> on adc.c without ts_filter, and then add the ts_filter core (plus support
> for s3c_ts) later on.
>
> I suppose you don't mind, so we'll go ahead with this and submit s3c_ts this
> way.

How could I mind? :-) This is the right way to go. I guess you could
make the driver send data with noise or restore the basic averaging in
previous versions of the driver.

TS filters have been rather controversial and they would slow down
s3c_ts merging. The filters should be submitted separately.
