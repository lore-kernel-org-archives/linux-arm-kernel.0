From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 23 Dec 2014 15:35:20 +0900
Subject: [PATCHv5 3/9] devfreq: event: Add exynos-ppmu devfreq-event driver
In-Reply-To: <5498F0F4.7020700@samsung.com>
References: <1419304697-14789-1-git-send-email-cw00.choi@samsung.com>
 <1419304697-14789-4-git-send-email-cw00.choi@samsung.com>
 <CAEUmHyYnb8_HNnuz8BLhMOh01+gpXfTv63P-ubYE1DK9uptonA@mail.gmail.com>
 <5498F0F4.7020700@samsung.com>
Message-ID: <54990D28.2050205@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varka,

On 12/23/2014 01:35 PM, Chanwoo Choi wrote:
> On 12/23/2014 12:40 PM, Varka Bhadram wrote:
>> On Tue, Dec 23, 2014 at 8:48 AM, Chanwoo Choi <cw00.choi@samsung.com> wrote:
>>> This patch adds exynos-ppmu devfreq-event driver to get performance data
>>> of each IP for Samsung Exynos SoC. These event from Exynos PPMU provide
>>> useful information about the behavior of the SoC that you can use when
>>> analyzing system performance, and made visible and can be counted using
>>> logic in each IP.
>>>
>>> This patch is based on existing drivers/devfreq/exynos/exynos-ppmu.c
>>>
>>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
>>> Cc: Kyungmin Park <kyungmin.park@samsung.com>
>>> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
>>

snip.

> 
>>
>>> +       }
>>> +
>>> +       data->clk_ppmu = devm_clk_get(dev, "ppmu");
>>> +       if (IS_ERR(data->clk_ppmu)) {
>>> +               data->clk_ppmu = NULL;
>>> +               dev_warn(dev, "failed to get PPMU clock\n");
>>> +       }
>> If PPMU clk get fails..?  return PTR_ERR(data->clk_ppmu)
> 
> If Exynos SoC don't register the clock to clock tree, the clock remains on state.
> So, I print just warning message.
> 
> But, It is not proper. I'll fix it.

I faced on unthinkable issue. I'm implementing missing PPMU clock of Exynos3250 (PPMUDMC0, PPMUDMC1, PPMUFSYS).
But, I can't find the parent clock of PPMUDMC0, PPMUDMC1 and the clock of PPMUFSYS on Exynos3250 datasheet.
Like this, some PPMU clocks is not specified on Exynos SoC datasheet because some clocks should be remained
with always-on state.

So, I want to show just warning message if exynos-ppmu driver fail to get ppmu clock.

Thanks,
Chanwoo Choi
