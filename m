From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 6 Aug 2015 09:17:38 +0200
Subject: [PATCH v4 0/6] ARM: shmobile: r8a7740/sh73a0 DT Cache Handling
In-Reply-To: <20150806003511.GB17231@verge.net.au>
References: <1438765090-823-1-git-send-email-geert+renesas@glider.be>
 <20150806003511.GB17231@verge.net.au>
Message-ID: <CAMuHMdW5D2LGA=3+JDiAUhVtPmxk3ZJhAx3=JXFuAHBAgU_NTw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 6, 2015 at 2:35 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Aug 05, 2015 at 10:58:04AM +0200, Geert Uytterhoeven wrote:
>> This patch series add L1 and L2 cache descriptions to DT for r8a7740 and
>> sh73a0, and migrates the shmobile DT-based generic r8a7740 and
>> armadillo legacy platforms from calling l2x0_of_init() to the generic
>> l2c OF initialization.

>> Dependencies:
>>   - This series applies to renesas-devel-20150805-v4.2-rc5,
>>   - Patch 2 depends on patch 1,
>>   - Patch 4 depends on patch 2,

Sorry, "... on patch 3".

>>   - Patch 5 depends on patch 1 and on "ARM: 8395/1: l2c: Add support for
>>     the "arm,shared-override" property" in arm/for-next,
>>   - Patch 6 depends on patch 5.
>>
>> Given C code patches depending on DT patches in the same branch are
>> frowned upon, I think it would be best if patch 1 (and patch 3, if
>> anyone thinks we may fix the secondary CPU bringup issue during the next
>> 3 months) are queued for v4.3. The other patches can be queued for
>> 2016^H^H^H^Hv4.4.
>
> Sorry for surprising you with that merge-order requirement.

In theory it sounds fine, as DT and code are independent.
Moving functionality from C to DT is something different...

> Unfortunately I am not comfortable with taking patch 1 for v4.3 because:
> 1. Its now very late in the cycle

I understand.

> 2. There now seems to be some discussion around it.

Yeah, that's what v4s are for...

Let's wait and see if/when it settles...

> I think I am happy to take the other patches for v4.4, now. But perhaps
> I should wait for the discussion around patch 1 to conclude first?

Which other patches? Patch 3 has the same issue as patch 1. And all
the rest depends on patch 1 or patch 3... So there's nothing left to
apply yet...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
