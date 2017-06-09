From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 9 Jun 2017 22:06:41 +0200
Subject: [PATCH] ARM64: Kconfig: Fix the missing hi655x common clk
In-Reply-To: <20170609154652.GG2244@mai>
References: <CALAqxLVn9r9R-wnrZbrFqYfwqZD-tegbJrZLsUeBjjBc4_Q89w@mail.gmail.com>
 <1496686434-13181-1-git-send-email-daniel.lezcano@linaro.org>
 <CAPDyKFqWptneK2V7wCR8LGbgU7=U9kBCKkHrtgGmZKmNQJ4s7g@mail.gmail.com>
 <20170609154652.GG2244@mai>
Message-ID: <CAK8P3a1PsFcqLC95rSQf6EdkqhQ6sE3OXC9gDQ8TLp2mTVO3pw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 9, 2017 at 5:46 PM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> On Tue, Jun 06, 2017 at 04:17:40PM +0200, Ulf Hansson wrote:
>> On 5 June 2017 at 20:13, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> > With the addition of the hi655x common clock, the config option is missing
>> > for the ARM64's hi6220 platform. That leads to a non functionnal WiFi because
>> > the hi655x clock driver misses when initializing the power sequence via DT.
>> >
>> > Cc: John Stultz <john.stultz@linaro.org>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Cc: Wei Xu <xuwei5@hisilicon.com>
>> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>>
>> Would be nice to get this trivial fix in for 4.12 rcs to make the WiFi
>> work for Hikey.
>>
>
> I'm wondering if I submitted this patch for the right path.
>
> Shall it go through arm-soc ?

Yes, but I'm not sure this is the right patch either. We tend to not
use 'select' for user-visible drivers, and most hisilicon platforms
won't need this driver.

I think it would be more consistent to add this to the defconfig
and regard it as a user error when the driver is disabled on a
machine that needs it.

       Arnd
