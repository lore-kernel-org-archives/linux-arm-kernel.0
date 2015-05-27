From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Wed, 27 May 2015 09:36:17 +0100
Subject: [RFC PATCH 0/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <CALszF6BTu_8SCE9hEiLYuvQg8J9eG5xktaVV7_LvnG3r20+wtw@mail.gmail.com>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
 <CALszF6BTu_8SCE9hEiLYuvQg8J9eG5xktaVV7_LvnG3r20+wtw@mail.gmail.com>
Message-ID: <55658201.5090208@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/05/15 17:41, Maxime Coquelin wrote:
>>   2. Allocating ~80 clock components appears to fragment memory enough
>>      to prevent busybox (.text is ~300K, non-XIP) from running getty.
>>      I have to use "init=/bin/sh" to avoid OOM problems.
>
> Yes, I reproduced the same issue while testing your work.
>
> Could you try with:
> CONFIG_NOMMU_INITIAL_TRIM_EXCESS=0
>
> It solves (hides) the problem on my side.
> You can eventually setting it once booted to 1 via procfs.

That works for me too. Thanks.

Incidentally switching to SLOB also reduced the problem for me. It was 
OK whilst I had ~20 clocks (and debugfs) but not enough for me to run 
with all the clocks registered.


Daniel.
