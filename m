From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Thu, 14 Nov 2013 12:42:56 +0100
Subject: a bug on NO_HZ_FULL_ALL
In-Reply-To: <52848547.9080604@linaro.org>
References: <CANHzE=2EOJmjFqLUDSfxTvgQhrUogOxH8Qux9hBFTGf8HiWWEw@mail.gmail.com>
 <52843855.5060509@linaro.org> <52847FBE.9070501@linaro.org>
 <CAKfTPtD7fo08mjQoLXMMDpyxQuyoCZLS33qBnnUcQEmzYai2VQ@mail.gmail.com>
 <52848547.9080604@linaro.org>
Message-ID: <20131114114253.GA16501@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 14, 2013 at 01:39:43PM +0530, viresh kumar wrote:
> On Thursday 14 November 2013 01:35 PM, Vincent Guittot wrote:
> > AFAICT, It's a none issue. In full nohz, a timer fires periodically
> > (around 4sec period on ARM IIRC) on one cpu (cpu0).
> 
> Timer should always be running on CPU0, its out of nohz-full domain. Its
> cpu 1, where it will fire after long delays..
> 
> 
> https://wiki.linaro.org/WorkingGroups/PowerManagement/Doc/AdaptiveTickless

Right. CPU 0 stays pure periodic unless you select CONFIG_NO_HZ_FULL_SYSIDLE=y
then it can be also nohz when the full system is idle. I strongly recommend for power
consumption.
