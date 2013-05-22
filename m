From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 22 May 2013 16:26:20 +0300
Subject: [PATCH] dmatest: abort transfers immediately when asked for
In-Reply-To: <20130522124112.GA16361@mudshark.cambridge.arm.com>
References: <20130516153553.GI11706@mudshark.cambridge.arm.com>
 <1369139597-24446-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20130521151143.GH10453@mudshark.cambridge.arm.com>
 <CAHp75VdRn8baf0ak57HpoJKNues6vEsjBp1uOQ2Zpvwa+B5rjA@mail.gmail.com>
 <20130522124112.GA16361@mudshark.cambridge.arm.com>
Message-ID: <CAHp75Ve=W7bNYK3Vr_xx41SCHsHtAAA1NcPK1CwetoZNsuVe1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 3:41 PM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, May 21, 2013 at 06:24:15PM +0100, Andy Shevchenko wrote:
>> On Tue, May 21, 2013 at 6:11 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > I now observe buffer verification failures in subsequent
>> > test runs after an aborted run:
>>
>> I think the description to the commit adfa543e "dmatest: don't use
>> set_freezable_with_signal()" may shed light on this.
>>
>> The background (if  I got it correctly) is in race with done flag. So,
>> we got a callback call from the DMA engine, but we don't know which
>> transfer triggers it.
>> I might be wrong. This is just an assumption.
>
> I've not managed to work out exactly what's going on, but it's certainly
> something like that. In fact, I just managed to trigger a case where all but
> one of the transfers is aborted, whilst the remaining one fails. Looking at
> the code, I can't see how that situation comes about, since the threads are
> protected with the info mutex and kthread_stop is synchronous.

>> Have you ever see such behaviour on pre v3.10-rc1 kernels? (I mean
>> with old dmatest module)
>
> No, dmatest from 3.9 is completely reliable in my experience.

Yeah, I supposed that was a rhetorical question.

So, have I understood correctly that if you revert the 77101ce5
("cancel thread ...")
everything is working fine / as before?

--
With Best Regards,
Andy Shevchenko
