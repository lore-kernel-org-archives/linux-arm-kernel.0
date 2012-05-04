From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 4 May 2012 11:41:15 +0800
Subject: [PATCH 3/9] ARM: mmp: support DT in irq
In-Reply-To: <201205021251.16967.arnd@arndb.de>
References: <1335515957-1798-1-git-send-email-haojian.zhuang@gmail.com>
 <20120427190620.D3C313E0B4D@localhost>
 <CAN1soZz5b0bc10isc6syxM7WzKfvVqc-HzotW6Auqv1A1mnC9A@mail.gmail.com>
 <201205021251.16967.arnd@arndb.de>
Message-ID: <CAN1soZwE7MoifmxtPS8f_x6CrK-dF97=vPMTMStg=VW1wsoLrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 2, 2012 at 8:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 02 May 2012, Haojian Zhuang wrote:
>> I use two CONFIG_OF in this file. The first one is used to record
>> register base address
>> of interrupt controller. In legacy code, the register address is
>> hardcoding. Do you mean
>> that I should remove this CONFIG_OF?
>
> Unless it's a noticeable performance impact, I would recommend just
> always using the mmp_icu_base variable, even for when CONFIG_OF is
> disabled.
>
> ? ? ? ?Arnd

But I appended new irq handler for DT support. I still need to reserve
this CONFIG_OF
since I need to keep compatible with legacy code. While everything in
arch-mmp is moved
into DT, I can remove this CONFIG_OF.

For the second CONFIG_OF, I can try to remove it.

Best Regards
Haojian
