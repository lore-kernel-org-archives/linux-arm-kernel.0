From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Tue, 17 Jan 2012 21:11:37 +0100
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled by
 uBoot)?
In-Reply-To: <20120117194724.GI16726@n2100.arm.linux.org.uk>
References: <CAMQu2gyBVOyWSCT39jP6xEtoNKrUCuaj_QTD+1EVhXgVc_H2HA@mail.gmail.com>
 <20120116131329.GA928@n2100.arm.linux.org.uk>
 <CAMQu2gzPGrbBd4_SOM0TFfGH_Y+XYzoh2XjsoPgpzU10tFOpYQ@mail.gmail.com>
 <WC20120117085444.17057E@terrafix.co.uk> <20120117121138.GC11475@arm.com>
 <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
 <20120117194724.GI16726@n2100.arm.linux.org.uk>
Message-ID: <CAMQu2gyjGYooWih=cK72VYEe8X_bKyOi3_eHec7cWi37CHBoJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 8:47 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 17, 2012 at 04:27:21PM +0000, Catalin Marinas wrote:
>> Anyway, the first step is this API provided by the secure firmware.
>> Since such API may need to be called before the MMU is initialised,
>> Linux would need to have knowledge of the platform type early on. Having
>> some platform hook (asm macro) to call early on wouldn't work with the
>> single zImage configuration. Stack space is not an issue as we already
>> have one for ARMv7 for D-cache flushing (XIP kernels would work but they
>> aren't that many).
>
> It _is_ a problem. ?How much stack space would these undefined platform
> specific functions require? ?16 words? ?32 words? ?A page? ?Where does
> this memory come from? ?The .data section, or are we going to stuff it
> into what is supposed to be the read-only text section?

Stack requirement is limited to saving and restoring the processor
registers. There is no additional need. If this is an issue, we can also use
SRAM as a stack for this operation.

Regards
Santosh
