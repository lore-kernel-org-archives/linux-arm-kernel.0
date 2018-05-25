From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 25 May 2018 15:48:39 +0530
Subject: [PATCH] mmc: sdhci-*: Don't emit error msg if sdhci_add_host()
 fails
In-Reply-To: <20180525151509.0270dbe1@xhacker.debian>
References: <20180525151509.0270dbe1@xhacker.debian>
Message-ID: <20180525101839.vfzyhyt5uwduhdcc@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25-05-18, 15:15, Jisheng Zhang wrote:
> I noticed below error msg with sdhci-pxav3 on some berlin platforms:
> 
> [.....] sdhci-pxav3 f7ab0000.sdhci failed to add host
> 
> It is due to getting related vmmc or vqmmc regulator returns
> -EPROBE_DEFER. It doesn't matter at all but it's confusing.
> 
> From another side, if driver probing fails and the error number isn't
> -EPROBE_DEFER, the core will tell us something as below:
> 
> [.....] sdhci-pxav3: probe of f7ab0000.sdhci failed with error -EXX
> 
> So it's not necessary to emit error msg if sdhci_add_host() fails. And
> some other sdhci host drivers also have this issue, let's fix them
> together.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/mmc/host/sdhci-spear.c    | 4 +---

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
