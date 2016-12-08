From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 8 Dec 2016 12:59:54 +0100
Subject: Tearing down DMA transfer setup after DMA client has finished
In-Reply-To: <yw1x60mu1w7e.fsf@unicorn.mansr.com>
References: <58356EA8.2010806@free.fr> <20161125045549.GC2698@localhost>
 <092f44ee-4560-be17-25f7-00948dba3cfa@free.fr>
 <20fc9020-7278-bc2f-2a8d-43aff5cabff8@free.fr>
 <20161206051222.GQ6408@localhost> <5846B237.8060409@free.fr>
 <yw1xwpfd2o9f.fsf@unicorn.mansr.com> <20161207164341.GX6408@localhost>
 <yw1xr35j1yd5.fsf@unicorn.mansr.com> <20161208103921.GC6408@localhost>
 <yw1x60mu1w7e.fsf@unicorn.mansr.com>
Message-ID: <CAMuHMdUEXJtWF3S8yK5RY5e60nOnb-Wc9U2E_L553hZvsijvcw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 8, 2016 at 12:44 PM, M?ns Rullg?rd <mans@mansr.com> wrote:
> Vinod Koul <vinod.koul@intel.com> writes:
>> On Wed, Dec 07, 2016 at 04:45:58PM +0000, M?ns Rullg?rd wrote:
>>> Vinod Koul <vinod.koul@intel.com> writes:
>>> > On Tue, Dec 06, 2016 at 01:14:20PM +0000, M?ns Rullg?rd wrote:
>>> >> That's not going to work very well.  Device drivers typically request
>>> >> dma channels in their probe functions or when the device is opened.
>>> >> This means that reserving one of the few channels there will inevitably
>>> >> make some other device fail to operate.
>>> >
>>> > No that doesnt make sense at all, you should get a channel only when you
>>> > want to use it and not in probe!
>>>
>>> Tell that to just about every single driver ever written.
>>
>> Not really, few do yes which is wrong but not _all_ do that.
>
> Every driver I ever looked at does.  Name one you consider "correct."

I'm far from claiming that drivers/tty/serial/sh-sci.c is perfect, but it does
request DMA channels at open time, not at probe time.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
