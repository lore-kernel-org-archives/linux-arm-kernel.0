From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 30 Nov 2011 22:47:33 +0800
Subject: [V3 1/6] RTC: sa1100: Clean out ost register
In-Reply-To: <20111130134624.GA18533@game.jcrosoft.org>
References: <1322634584-4347-1-git-send-email-jtzhou@marvell.com>
 <20111130134624.GA18533@game.jcrosoft.org>
Message-ID: <CAN1soZx_-mXYTr94T9dWLaiEb=tnS8HOyY3mXq6ugcArDMrF-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 9:46 PM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 14:29 Wed 30 Nov ? ? , Jett.Zhou wrote:
>> These registers are used in old ioctl of UIE and PIE, now they are
>> emulated by rtc generic code of hrtimer, so it can be removed.
>>
>> Signed-off-by: Jett.Zhou <jtzhou@marvell.com>
>> Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
>> ---
>> ?drivers/rtc/rtc-sa1100.c | ? ?3 ---
>> ?1 files changed, 0 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
>> index 0b40bb8..6f22c1f 100644
>> --- a/drivers/rtc/rtc-sa1100.c
>> +++ b/drivers/rtc/rtc-sa1100.c
>> @@ -36,7 +36,6 @@
>>
>> ?#ifdef CONFIG_ARCH_PXA
>> ?#include <mach/regs-rtc.h>
> please move this to include/linux too
> to allow ?the simgle zImage
>
> Best Regards,
> J.

This patch is used to remove <mach/regs-ost.h>. <regs-rtc.h> will be
removed in the rest of this patch series. Please check the third
patch.
