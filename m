From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Feb 2012 15:30:01 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
References: <1328578047.1724.17.camel@dave-Dell-System-XPS-L502X>
 <CAMQu2gwfo5JXAqQaLUNs7C7J3TUhEO2zOcyD0Rk-D_O61Yrfag@mail.gmail.com>
 <CAMsRxfLNBbQO5XF+EHJqNsnW+s=ay3mjSV5dh=sxdwzktUu03g@mail.gmail.com>
 <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
Message-ID: <20120207153001.GA2367@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephane,

On Tue, Feb 07, 2012 at 11:59:21AM +0000, stephane eranian wrote:
> An easier way to verify we're getting the right number of samples is
> to use perf top:
> 
> $ taskset -c 1 noploop 1000 &
> $ sudo perf top
> 
> You'll see around 850 irqs/sec, should be closer to 1000.
> But if I drop the rate to 100Hz, then it works:
> 
> $ sudo perf top -F 100
> 
> That leads me to believe there is too much overhead somewhere.
> Could be in perf_event itself.
> 
> Will, do you get 1000 irsq/sec running the same test on your systems?

I'm away from my dev boards at the moment, but I'll give this a go next week
and get back to you.

Will
