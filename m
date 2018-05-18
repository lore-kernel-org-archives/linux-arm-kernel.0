From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 18 May 2018 12:17:15 +0530
Subject: [PATCH] clk: davinci: psc-da830: fix USB0 48MHz PHY clock
 registration
In-Reply-To: <9f8a876b-6a66-687c-f83f-51b8d896c50a@ti.com>
References: <20180507113457.4716-1-nsekhar@ti.com>
 <152642368847.237094.1884631416189964435@swboyd.mtv.corp.google.com>
 <9f8a876b-6a66-687c-f83f-51b8d896c50a@ti.com>
Message-ID: <4f289b8c-6dc2-a5e6-bda3-d3dc8e61ea1f@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Wednesday 16 May 2018 10:44 AM, Sekhar Nori wrote:
> Hi Stephen,
> 
> On Wednesday 16 May 2018 04:04 AM, Stephen Boyd wrote:
>> Quoting Sekhar Nori (2018-05-07 04:34:57)
>>> USB0 48MHz PHY clock registration fails on DA830 because the
>>> da8xx-cfgchip clock driver cannot get a reference to USB0
>>> LPSC clock.
>>>
>>> The USB0 LPSC needs to be enabled during PHY clock enable. Setup
>>> the clock lookup correctly to fix this.
>>>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> ---
>>
>> Applied to clk-next
>>
>> Did this need a fixes tag? And should it go into 4.17 final? Or it's not
>> causing problems right now?
> 
> We have not switched DaVinci to use common clock framework still. So no,
> this does not cause problems right now. All drivers/clk/davinci/*
> patches can be included for v4.18.

There are some more patches (fixes) to drivers/clk/davinci which have
been reviewed and both David and I think are ready for merge[1].

Do you have them in your queue? Else, I can send a pull request for you
to take a look and merge.

Thanks,
Sekhar

[1]
clk: davinci: psc-dm365: fix few clocks
clk: davinci: pll-dm646x: keep PLL2 SYSCLK1 always enabled
clk: davinci: psc-dm355: fix ASP0/1 clkdev lookups
clk: davinci: pll-dm355: fix SYSCLKn parent names
clk: davinci: pll-dm355: drop pll2_sysclk2
