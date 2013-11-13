From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 13 Nov 2013 09:14:59 -0800
Subject: [PATCH 5/7] clocksource/cadence_ttc: Overhaul clocksource
 frequency adjustment
In-Reply-To: <CAKohpo=KaM97jJ2MnZxSeBz=Mf9cSmzk_EFQTL=EVPPvSH=Wag@mail.gmail.com>
References: <1383945677-29674-1-git-send-email-soren.brinkmann@xilinx.com>
 <1383945677-29674-6-git-send-email-soren.brinkmann@xilinx.com>
 <52827B11.5040308@linaro.org>
 <CAKohpo=KaM97jJ2MnZxSeBz=Mf9cSmzk_EFQTL=EVPPvSH=Wag@mail.gmail.com>
Message-ID: <2c13b204-2022-4091-95be-1749e8cc60b0@CH1EHSMHS026.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 13, 2013 at 01:33:52PM +0530, Viresh Kumar wrote:
> On 13 November 2013 00:31, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> > Hmm, it could be interesting if Viresh can give its opinion on this patch
> > [cc'ed].
> 
> I am not sure if I understood the problem completely, but if this is about
> not allowing frequency transitions from cpufreq when we have started to
> suspend our system, then you must have a look at this thread:
> 
> https://lkml.org/lkml/2013/10/24/369

Thanks for the link. I had problems in that direction at some point too.
But the current issue, is not cpufreq changing the frequency, but our
suspend code in prepare_late() causes a frequency change of this timer
when the PLLs are powered down (it's done through a CCF clk_set_parent()
operation).

	S?ren
