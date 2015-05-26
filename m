From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue, 26 May 2015 18:41:09 +0200
Subject: [RFC PATCH 0/3] clk: stm32: Add clock driver for STM32F4[23]xxx
 devices
In-Reply-To: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
References: <1432327273-6810-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <CALszF6BTu_8SCE9hEiLYuvQg8J9eG5xktaVV7_LvnG3r20+wtw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

2015-05-22 22:41 GMT+02:00 Daniel Thompson <daniel.thompson@linaro.org>:
>  2. Allocating ~80 clock components appears to fragment memory enough
>     to prevent busybox (.text is ~300K, non-XIP) from running getty.
>     I have to use "init=/bin/sh" to avoid OOM problems.
>

Yes, I reproduced the same issue while testing your work.

Could you try with:
CONFIG_NOMMU_INITIAL_TRIM_EXCESS=0

It solves (hides) the problem on my side.
You can eventually setting it once booted to 1 via procfs.

Kind regards,
Maxime
