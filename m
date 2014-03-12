From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 13 Mar 2014 07:26:47 +0900
Subject: [PATCH] ARM: shmobile: Break out R-Car SYSC PM code
In-Reply-To: <20140309052210.GB12854@quad.lixom.net>
References: <20140115074308.8471.64824.sendpatchset@w520>
 <CAOesGMjaTB-kBrm1av0uc8N-+4TRBZm5fxjJbsZLJe5OuqLu+g@mail.gmail.com>
 <CANqRtoRMkezRZvoH4Q1T3mwwhU9T=ZOFVGE5KN+sLBEqpXO=mg@mail.gmail.com>
 <CANqRtoQ2PDb5siknAndO3TgDghgTKPVa-ez-t2eQDcypDnsJTw@mail.gmail.com>
 <20140309052210.GB12854@quad.lixom.net>
Message-ID: <CANqRtoQx16qgC-5wxi_SPDKMy+qztt-aTTa7TEY04+aT4a1=wA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 9, 2014 at 2:22 PM, Olof Johansson <olof@lixom.net> wrote:
> On Tue, Feb 25, 2014 at 11:09:52AM +0900, Magnus Damm wrote:
>> Hi Olof,
>>
>> On Thu, Feb 20, 2014 at 6:45 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> > On Thu, Feb 20, 2014 at 6:36 PM, Olof Johansson <olof@lixom.net> wrote:
>> >> I spotted this patch since it adds new include/mach contents, comment below:
>> >>
>> >> On Tue, Jan 14, 2014 at 11:43 PM, Magnus Damm <magnus.damm@gmail.com> wrote:
>> >>
>> >>> --- /dev/null
>> >>> +++ work/arch/arm/mach-shmobile/include/mach/pm-rcar.h  2014-01-15 13:30:38.000000000 +0900
>> >>> @@ -0,0 +1,15 @@
>> >>> +#ifndef PM_RCAR_H
>> >>> +#define PM_RCAR_H
>> >>> +
>> >>> +struct rcar_sysc_ch {
>> >>> +       unsigned long chan_offs;
>> >>> +       unsigned int chan_bit;
>> >>> +       unsigned int isr_bit;
>> >>> +};
>> >>> +
>> >>> +int rcar_sysc_power_down(struct rcar_sysc_ch *sysc_ch);
>> >>> +int rcar_sysc_power_up(struct rcar_sysc_ch *sysc_ch);
>> >>> +bool rcar_sysc_power_is_off(struct rcar_sysc_ch *sysc_ch);
>> >>> +void __iomem *rcar_sysc_init(phys_addr_t base);
>> >>> +
>> >>> +#endif /* PM_RCAR_H */
>> >>
>> >>
>> >> These prototypes are only ever used by code in arch/arm/mach-shmobile,
>> >> right? There's no reason to expose it to the global include namespace,
>> >> and you'll just have to remove it when the platform is converted to
>> >> multiplatform.
>> >>
>> >> So, I suggest moving this to be at arch/arm/mach-shmobile/pm-rcar.h
>> >> instead (and included as "pm-rcar.h" instead of <mach/pm-rcar.h>).
>> >
>> > Thanks for your help with the patches! You are right that these are
>> > never used outside mach-shmobile, and moving headers out of "mach"
>> > certainly makes sense.
>>
>> FYI, the following series includes my attempt to address this issue:
>>
>> [PATCH 00/12] ARM: shmobile: Rework include path for SoC files
>> [PATCH 01/12] ARM: shmobile: Add temporary include workaround
>> [PATCH 02/12] ARM: shmobile: Rework include path for sh7372
>> [PATCH 03/12] ARM: shmobile: Rework include path for sh73a0
>> [PATCH 04/12] ARM: shmobile: Rework include path for EMEV2
>> [PATCH 05/12] ARM: shmobile: Rework include path for r8a7740
>> [PATCH 06/12] ARM: shmobile: Rework include path for r8a7778
>> [PATCH 07/12] ARM: shmobile: Rework include path for r8a7779
>> [PATCH 08/12] ARM: shmobile: Rework include path for r8a7790
>> [PATCH 09/12] ARM: shmobile: Rework include path for r8a7791
>> [PATCH 10/12] ARM: shmobile: Rework include path for r8a73a4
>> [PATCH 11/12] ARM: shmobile: Rework include path for r7s72100
>> [PATCH 12/12] ARM: shmobile: Rework include path for common bits
>>
>> If you would like me to rework the code somehow then please let me
>> know. I also intend to ask a different developer to convert the actual
>> boards once these changes have been merged by Simon, hope this is a
>> good way forward for you.
>
> It certainly looks like a good way forward, thanks for doing this.

Ok, thanks. The list of patches above is the first step forward from my side.

I'm afraid that I'm a bit confused by your comments in thread:
"Re: [PATCH v2] ARM: shmobile: Add temporary include workaround"

The single v2 patch on the line above is just a bug fixed version of [01/12].

Can you please clarify if you're ok with the series or if you want me
to rework it somehow?

> (Apologies for the delay in response, I've been ignoring my upstream email for
> a while and I'm dealing with the backlog now)

No problem!

Thanks,

/ magnus
