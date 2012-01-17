From: notasas@gmail.com (Grazvydas Ignotas)
Date: Tue, 17 Jan 2012 16:18:35 +0200
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <20120117133918.GE11475@arm.com>
References: <WC20120116100344.4204CC@terrafix.co.uk>
 <CAMQu2gw4H=m1QA+ucORYsO_LZR8Sj57=+jwmrkHu_7sdCzhN8g@mail.gmail.com>
 <20120116105949.GG16726@n2100.arm.linux.org.uk>
 <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk>
 <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
Message-ID: <CANOLnONLVM8zRckvSLE538qHHjQaie7xMmxAhhhn9zvPdYuoVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 3:39 PM, Catalin Marinas
<catalin.marinas@arm.com> wrote:
> On Tue, Jan 17, 2012 at 12:40:54PM +0000, Shilimkar, Santosh wrote:
>> Well the L2 can be configured as inner or outer, so above
>> alone won't work.
>>
>> Boot-loader disabling L2 cache ( all caches) ?is still right thing
>> and that's what kernel expect.
>>
>> Since the early kernel code can't be patches for A8, may be
>> delaying L2 enabled would work.
>
> Ah, I missed the fact that the L2 is an inner cache on OMAP3+A8.

At least on my OMAP3 board it's not. There is L2 AUX control register
"L2 inner" bit that's always cleared here. I know outer cacheablility
bits in page table descriptors have effect here, we have tested
performace before..


-- 
Gra?vydas
