From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 2 Jan 2017 15:42:47 +0530
Subject: [PATCH v4 4/4] ARM: da850: fix da850_set_pll0rate()
In-Reply-To: <1481124138-27337-5-git-send-email-bgolaszewski@baylibre.com>
References: <1481124138-27337-1-git-send-email-bgolaszewski@baylibre.com>
 <1481124138-27337-5-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <a04624ec-6c6e-6a5b-0626-cc3520cccb29@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 December 2016 08:52 PM, Bartosz Golaszewski wrote:
> This function is confusing - its second argument is an index to the
> freq table, not the requested clock rate in Hz, but it's used as the
> set_rate callback for the pll0 clock. It leads to an oops when the
> caller doesn't know the internals and passes the rate in Hz as
> argument instead of the cpufreq index since this argument isn't bounds
> checked either.
> 
> Fix it by iterating over the array of supported frequencies and
> selecting a one that matches or returning -EINVAL for unsupported
> rates.
> 
> Also: update the davinci cpufreq driver. It's the only user of this
> clock and currently it passes the cpufreq table index to
> clk_set_rate(), which is confusing. Make it pass the requested clock
> rate in Hz.
> 
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Applied to v4.11/fixes-non-critical

Thanks,
Sekhar
