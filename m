From: slash.tmp@free.fr (Mason)
Date: Thu, 8 Dec 2016 13:17:08 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <CAMuHMdWXVW9BG=MZGptibDTxDd5=7iCbiq1cmbD+qu-CZ0Y_7g@mail.gmail.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <91b0d10c-1bc2-c3e1-4088-f4ad9adcd6c0@free.fr>
 <CAMuHMdUULnPuTqEwRN2Z3gy2nmV37iLwJdNzrEvgpcG-EJS8OQ@mail.gmail.com>
 <yw1x1sxi1w3i.fsf@unicorn.mansr.com>
 <CAMuHMdWXVW9BG=MZGptibDTxDd5=7iCbiq1cmbD+qu-CZ0Y_7g@mail.gmail.com>
Message-ID: <964975b8-5c00-9726-20e4-a1e801ce28d6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2016 13:03, Geert Uytterhoeven wrote:

> M?ns Rullg?rd wrote:
>
>> Geert Uytterhoeven writes:
>>
>>> Can you fall back to PIO if requesting a channel fails?
>>
>> Why are we debating this nonsense?  There is an easy fix that doesn't
>> require changing the semantics of existing functions or falling back to
>> slow pio.
> 
> You still want to fall back to PIO if the DMA engine is not available
> at all (e.g. DMA engine driver not compiled in, or module not loaded).

FWIW, the ECC engine is tied to the DMA engine. So PIO means
not only taking a hit from tying up the CPU for a slooow
transfer, but also a huge hit if ECC must be computed in SW.
(A 100x perf degradation is not unlikely.)

Regards.
