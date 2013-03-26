From: robherring2@gmail.com (Rob Herring)
Date: Mon, 25 Mar 2013 21:19:46 -0500
Subject: [PATCH] ARM: convert arm/arm64 arch timer to use CLKSRC_OF init
In-Reply-To: <5150D54D.1070004@linaro.org>
References: <1363818875-15978-1-git-send-email-robherring2@gmail.com>
 <20130325172633.GP30923@n2100.arm.linux.org.uk> <5150C16A.3040208@gmail.com>
 <201303252236.23270.arnd@arndb.de> <5150D54D.1070004@linaro.org>
Message-ID: <515105C2.9060002@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/25/2013 05:53 PM, John Stultz wrote:
> On 03/25/2013 03:36 PM, Arnd Bergmann wrote:
>> On Monday 25 March 2013, Rob Herring wrote:
>>> I count integrator-cp, realview, versatile and non-DT VExpress that do
>>> this (not surprisingly) and 25 platforms or timer implementations plus
>>> arm64 that do sched_clock setup in time_init. What's broken by not
>>> moving these earlier?
>> timekeeping_init() will leave the persistent_clock_exist variable as
>> "false",
>> which is read in rtc_suspend() and timekeeping_inject_sleeptime().
> 
> Are you mixing up the persistent_clock and sched_clock here? From a
> generic stand-point they have different requirements.

Yes. We're talking about sched_clock here. What would be the benefit of
having it setup before sched_init vs. later in time_init?

Rob
