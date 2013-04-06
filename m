From: linux@prisktech.co.nz (Tony Prisk)
Date: Sun, 07 Apr 2013 10:06:57 +1200
Subject: PWM backlight build warning
In-Reply-To: <20130406211041.GA15987@avionic-0098.mockup.avionic-design.de>
References: <51606A7F.3050803@prisktech.co.nz>
 <20130406200251.GO6597@opensource.wolfsonmicro.com>
 <20130406211041.GA15987@avionic-0098.mockup.avionic-design.de>
Message-ID: <51609C81.5030207@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/04/13 09:10, Thierry Reding wrote:
> On Sat, Apr 06, 2013 at 09:02:51PM +0100, Mark Brown wrote:
>> On Sun, Apr 07, 2013 at 06:33:35AM +1200, Tony Prisk wrote:
>>
>>> The problem occurs because when CONFIG_PM=y but CONFIG_PM_SLEEP=n:
>>> I guess this would be a problem on every driver that has been
>>> converted to SIMPLE_DEV_PM_OPS.
>>> I don't know enough about the PM code to offer a fix, or whethermy
>>> chosen config is just 'invalid'.
>> You just need to put the system suspend functions inside an ifdef
>> CONFIG_PM_SLEEP instead of CONFIG_PM.
> I carry a fix for that in my for-next branch.
>
> Thierry
Ahh ok, all is good then.

Regards
Tony P
