From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 2 Nov 2009 22:19:58 -0400
Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
In-Reply-To: <87ws28aly2.fsf@free.fr>
References: <771cded00911020342j5266b3c4ga4e94324c2369630@mail.gmail.com>
	<87ws28aly2.fsf@free.fr>
Message-ID: <771cded00911021819o705e0a07l4fa18b6846d17c1b@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 2, 2009 at 1:14 PM, Robert Jarzmik <robert.jarzmik@free.fr> wrote:
> Haojian Zhuang <haojian.zhuang@gmail.com> writes:
>
>> From 1764e836424d42a0654b8b73c402a2dddb118dc4 Mon Sep 17 00:00:00 2001
>> From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Date: Mon, 2 Nov 2009 14:02:21 -0500
>> Subject: [PATCH] pxa: fix system resume issue on pxa27x and pxa3xx
>>
>> Since interrupt handler is changed to use interrupt priority, we also need to
>> save and restore these interrupt controller registers in suspend/resume
>> routine.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> Tested-by: Daniel Mack <daniel@caiaq.de>
>
> Yes, the fix does work for my platform too, well done.
> Tested-by: Robert Jarzmik <robert.jarzmik@free.fr>
>
> As a side note, the "128" magic number may have deserved a little define
> somewhere.
>
> Cheers.
>
> --
> Robert
>

Thanks of all good comments. Now I move the check into the
initialization code. If internal irq number is larger than 128, the
larger irqs won't be initialized. So suspend resume routine needn't
access the larger IPR registers. Patch is in below and attached.

Thanks
Haojian
