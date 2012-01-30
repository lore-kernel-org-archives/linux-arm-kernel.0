From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2012 17:24:38 +0000
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
References: <20120127171009.GL2347@mudshark.cambridge.arm.com>
 <CAMsRxfJufRMrcfGZp53ALOdEFLk+YDMvQMrHw-jR9tQ8ThE+-Q@mail.gmail.com>
 <CAMsRxfK5tv1DZmHH4F0BT+zVUboESiMmCkatO2NLHp03=e51fQ@mail.gmail.com>
 <CACVXFVMgDpaYeaU+0LGirYzNfJb8k0wFfL=+UU5qAwYfXgWLMQ@mail.gmail.com>
 <CAMsRxfJq1-tSQH4bv0BeNWXV9aysi9AUvywkh3e9SaamMDfZ0Q@mail.gmail.com>
 <CAMsRxf+okps60OxQnPkqHck8pWHrkPnT6boo603pC2XEbFYoRQ@mail.gmail.com>
 <CACVXFVMDXO3DDj0mGh=+uDYfCoS_Ck1STVK0=UXjiAbtJTa=hA@mail.gmail.com>
 <CAMsRxfLqvPN_k7vuC3qzBjwX2ihBdPxZvmSCPZ3frWgptWXQGA@mail.gmail.com>
 <yw1xsjixgolb.fsf@unicorn.mansr.com>
 <CAMsRxfJLsnBnKBrEXOSOWUTbgfeZtVZ6nR8jt388=baL5Mn22Q@mail.gmail.com>
Message-ID: <20120130172438.GC17814@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 05:15:53PM +0000, stephane eranian wrote:
> Still need to investigate why the frequency mode does
> not yield the correct number of samples even with low frequency.
> 
> 
> $ taskset -c 1 perf record -e cycles -F 100 noploop 10
> $ perf report -D | tail -20
> Aggregated stats:
>            TOTAL events:        475
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>           SAMPLE events:        460
> cycles stats:
>            TOTAL events:        475
>             MMAP events:         11
>             COMM events:          2
>             EXIT events:          2
>           SAMPLE events:        460
> 
> 460 samples is way too low. Should be 100x10 = 1000 samples or close to it.

Can you stick noploop.c somewhere (I'm lazy :) and I'll try it on one of my
A9 boards?

Thanks,

Will
