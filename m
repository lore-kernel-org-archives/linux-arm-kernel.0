From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Fri, 29 Jun 2012 09:18:07 +0800
Subject: [PATCH 1/3] mfd: support 88pm80x in 80x driver
In-Reply-To: <201206281432.24061.arnd@arndb.de>
References: <1340853214-5429-1-git-send-email-zhouqiao@marvell.com>
 <201206281121.56769.arnd@arndb.de>
 <20120628114616.GE28922@opensource.wolfsonmicro.com>
 <201206281432.24061.arnd@arndb.de>
Message-ID: <CAN1soZwwWhNC2pQjwYz-jUjNrnnPfshyPQJL-8uM6z6BKvCwMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 28, 2012 at 10:32 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Thursday 28 June 2012, Mark Brown wrote:
>> Show Details
>> ? On Thu, Jun 28, 2012 at 11:21:56AM +0000, Arnd Bergmann wrote:
>>
>> > What platform is this driver for?
>> > ?- If it's for an existing platform that does not have DT support, please
>> > ? ?include the platform changes for that platform so we can see what gets
>> > ? ?done in there.
>>
>> This is really not normal practice for device drivers, it'd be a serious
>> obstacle to getting drivers integrated if we have to have a board merged
>> with every driver.
>
> But it would be very helpful to see how the platform data is set, especially
> with the callback. If the callback is just there to set up a regulator
> or clock, then it should be changed to a more generic way.
>
> ? ? ? ?Arnd

No, the callbacks is not used to set up a regulator or clock. They're used to
configure the logic that are not integrated into drivers yet. For example, one
special regulator needs active in sleep mode; some power saving configuration
with board; accessing special register for fuse or OTP, .... Could we set up
milestones for this? I agree that we need to move to DT support. But we have
the interface of OF_DEV_AUXDATA in machine driver. We can use them to
deliver platform data even with callback into drivers.

By the way, this PMIC is installed on new platforms that are not
submitted patches
into mainline yet. They're used and verified in internal code without
DT support. The
plan is submitting PMIC pathces before the new platform. If we only
support DT, we
can't verify these code.

Regards
Haojian
