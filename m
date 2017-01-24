From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Tue, 24 Jan 2017 16:08:31 +0100
Subject: [PATCH v9 0/4] arm64: arch_timer: Add workaround for
 hisilicon-161010101 erratum
In-Reply-To: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
References: <1484832916-7248-1-git-send-email-dingtianhong@huawei.com>
Message-ID: <765699aa-cbc6-67eb-9108-cbf335338e4c@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/01/2017 14:35, Ding Tianhong wrote:
> Erratum Hisilicon-161010101 says that the ARM generic timer counter "has the
> potential to contain an erroneous value when the timer value changes".
> Accesses to TVAL (both read and write) are also affected due to the implicit counter
> read.  Accesses to CVAL are not affected.
> 
> The workaround is to reread the system count registers until the value of the second
> read is larger than the first one by less than 32, the system counter can be guaranteed
> not to return wrong value twice by back-to-back read and the error value is always larger
> than the correct one by 32. Writes to TVAL are replaced with an equivalent write to CVAL.

Why not use another clocksource instead of adding a workaround with a
non negligible overhead and more complexity in the code ?


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
