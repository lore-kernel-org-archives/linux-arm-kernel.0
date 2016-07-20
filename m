From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Jul 2016 13:49:50 +0200
Subject: [PATCH v4] xen/arm: Add a clock property
In-Reply-To: <cc28ef7e-dce3-fe5f-ab80-b662244bcbd0@arm.com>
References: <1468309605-19522-1-git-send-email-dirk.behme@de.bosch.com>
 <CAMuHMdU9yP2SMYa5ssrQSu1vwSN2gM4mD-EVYSGr2Pqf=jmCgw@mail.gmail.com>
 <cc28ef7e-dce3-fe5f-ab80-b662244bcbd0@arm.com>
Message-ID: <CAMuHMdWeJjcuBHjnjppc5Ys5Ew8VssXzg=dLpLPCOQaBnUo_7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Julien,

On Wed, Jul 20, 2016 at 1:01 PM, Julien Grall <julien.grall@arm.com> wrote:
> On 20/07/16 10:43, Geert Uytterhoeven wrote:
>> On Tue, Jul 12, 2016 at 9:46 AM, Dirk Behme <dirk.behme@de.bosch.com>
>> wrote:
>>>
>>> Clocks described by this property are reserved for use by Xen, and the OS
>>> must not alter their state any way, such as disabling or gating a clock,
>>> or modifying its rate. Ensuring this may impose constraints on parent
>>> clocks or other resources used by the clock tree.
>>>
>>> This property is used to proxy clocks for devices Xen has taken ownership
>>> of, such as UARTs, for which the associated clock controller(s) remain
>>> under the control of Dom0.
>>
>>
>> I'm not familiar with using XEN at all, but I'm a bit puzzled...
>>
>> Can't you just add a clocks property to the (virtual) serial device node
>> in DT?
>> Then the (virtual) serial device driver can get and enable the clock?
>
> There is no DT node for the Xen console (hvc). The UART used by Xen will be
> completely removed from the Device tree.

Why is it removed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
