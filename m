From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 24 Feb 2012 14:36:26 +0800
Subject: [PATCH v3 5/7] ARM: pxa: add rtc dummy clock
In-Reply-To: <20120223162738.GA22562@n2100.arm.linux.org.uk>
References: <1330012851-13693-1-git-send-email-haojian.zhuang@marvell.com>
 <1330012851-13693-6-git-send-email-haojian.zhuang@marvell.com>
 <20120223162738.GA22562@n2100.arm.linux.org.uk>
Message-ID: <CAN1soZw=Xe4rmcACeVDMyyqMWoXGnJj-jPEb-Dk52Zj=ce5vEg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 24, 2012 at 12:27 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Feb 24, 2012 at 12:00:49AM +0800, Haojian Zhuang wrote:
>> sa1100-rtc driver could be shared among sa1100/pxa/mmp series silicon.
>> Since clk is used in mmp series silicon, add dummy clock support in
>> pxa also.
>>
>> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
>> ---
>> ?arch/arm/mach-pxa/pxa25x.c | ? ?1 +
>> ?arch/arm/mach-pxa/pxa27x.c | ? ?1 +
>> ?arch/arm/mach-pxa/pxa3xx.c | ? ?1 +
>> ?arch/arm/mach-pxa/pxa95x.c | ? ?1 +
>> ?4 files changed, 4 insertions(+), 0 deletions(-)
>
> This is missing changes in arch/arm/mach-pxa/clock.c to prevent clk_enable()
> etc oopsing when called with a NULL clock.
>
Since I'm still using existed dummy clock in arch-pxa, I needn't to
append checking for NULL clock. The dummy clock do nothing for
clk_enable() & clk_disable().

I'll remove dummy clock in arch-pxa later.

Thanks
Haojian
