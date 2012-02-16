From: ming.lei@canonical.com (Ming Lei)
Date: Fri, 17 Feb 2012 00:37:35 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <1329409183.2293.245.camel@twins>
References: <CAMQu2gzfNAwtf1c6jrTZpfGMSqBgBrQKmFTeCFzbvMh9ESBDUg@mail.gmail.com>
 <CAMsRxfKR1ODH56BtcUT5Dv6qOVEYGVheEcW9ugXsZmLKok==bg@mail.gmail.com>
 <CAMQu2gwWt6oQPjxc1YHgOoxVkHdck_q78Xf==7ncwRj0_uS-JQ@mail.gmail.com>
 <CAMQu2gyCPtbNfBa5V8ve2JORN+sDeAY+hvR0g0_9U354JgcuiA@mail.gmail.com>
 <CAMsRxfJVEgVJoHcaPQbMg5mwz=tZUce4oibDUxtnevSF8bGY9g@mail.gmail.com>
 <CAMQu2gxVUqDF2HkPD=QeX0N_tUd=9FTd+T+1LHCR0tsCgQxC8Q@mail.gmail.com>
 <CAMsRxfJH+9MS=Svmh0BvDSb8xqsPe2HPobkeKcn8JO35npjhwQ@mail.gmail.com>
 <CACVXFVMx9Zx3ZQr6Q-17x5NVL8iuBJjOjtw39FJiWX=fGkZNZA@mail.gmail.com>
 <1329323900.2293.150.camel@twins>
 <CACVXFVPce0A3LfL=mFo3UbN-Om7xLOo_d-LfKXDjdN5dFQdhiA@mail.gmail.com>
 <20120216150004.GE2641@mudshark.cambridge.arm.com>
 <CACVXFVM472hz+na7o2wJr1CPq-W=YB7i0UwtrsUf62+ryzWp8A@mail.gmail.com>
 <1329409183.2293.245.camel@twins>
Message-ID: <CACVXFVOygObWqPMLjg6uOB6inBkvvUjsQncNW0fbmpa4Xspw0Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 12:19 AM, Peter Zijlstra <a.p.zijlstra@chello.nl> wrote:
> On Fri, 2012-02-17 at 00:12 +0800, Ming Lei wrote:
>> is triggered: u64 delta = 100 - ?1000000 = 18446744073708551716.
>
> on x86 we do:
>
> ?int shift = 64 - x86_pmu.cntval_bits;
> ?s64 delta;
>
> ?delta = (new_raw_count << shift) - (prev_raw_count << shift);
> ?delta >>= shift;
>
> This deals with short overflows (on x86 the registers are typically 40
> or 48 bits wide). If the arm register is 32 you can of course also get
> there with some u32 casts.

Good idea, but it may not work if new_raw_count is bigger than prev_raw_count.

thanks
--
Ming Lei
