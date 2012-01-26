From: k.lewandowsk@samsung.com (Karol Lewandowski)
Date: Thu, 26 Jan 2012 16:28:00 +0100
Subject: [PATCH v2 2/2] regulator: add device tree support for max8997
In-Reply-To: <20120125133254.GJ3687@opensource.wolfsonmicro.com>
References: <1326353738-26864-1-git-send-email-thomas.abraham@linaro.org>
 <1326353738-26864-3-git-send-email-thomas.abraham@linaro.org>
 <4F1FD1A5.1060305@samsung.com>
 <20120125112602.GB2991@opensource.wolfsonmicro.com>
 <4F1FEF55.8030604@samsung.com>
 <20120125133254.GJ3687@opensource.wolfsonmicro.com>
Message-ID: <4F217100.6020105@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.01.2012 14:32, Mark Brown wrote:
> On Wed, Jan 25, 2012 at 01:02:29PM +0100, Karol Lewandowski wrote:
>> On 25.01.2012 12:26, Mark Brown wrote:
>
>> However, I still find it little problematic that dt and non-dt
>> versions behave differently when given the same set of parameters
>> (previously apply_uV wasn't the default and required explicit flag).
>
> Well, they're different things.  Device tree isn't Linux specific at
> all.

There is no official platform-agnostic regulator API, nor DT-bindings
document I'm aware of.  Thus, I don't see why, while transitioning to
DT, should we lose ability to describe certain hardware configurations.

On 25.01.2012 12:22, Mark Brown wrote:
 > The big problem there seems like specifying voltages in the first
 > place, if we know what device it is we should already know what's
 > going on.

Driver which handles said regulator might know what's going on, but
that might not be case for its consumers.  Should we limit ability to
query given parameter just because its value is hardcoded in hardware?


My understanding of this whole device tree effort was to provide
ability to describe hardware properties which can't be queried from
hardware itself.

Consequently, if it's property of hardware that it provides fixed
voltage somewhere shouldn't it be possible to describe this fact
in DT?

If device tree isn't good place for it then which one is?

Regards,
-- 
Karol Lewandowski | Samsung Poland R&D Center | Linux/Platform
