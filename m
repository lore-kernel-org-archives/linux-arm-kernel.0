From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 9 Jan 2017 16:08:43 -0800
Subject: [PATCH] clk: scpi: don't add cpufreq device if the scpi dvfs
 node is disabled
In-Reply-To: <1483706070-12357-1-git-send-email-sudeep.holla@arm.com>
References: <1483706070-12357-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <20170110000843.GC17126@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/06, Sudeep Holla wrote:
> Currently we add the virtual cpufreq device unconditionally even when
> the SCPI DVFS clock provider node is disabled. This will cause cpufreq
> driver to throw errors when it gets initailised on boot/modprobe and
> also when the CPUs are hot-plugged back in.
> 
> This patch fixes the issue by adding the virtual cpufreq device only if
> the SCPI DVFS clock provider is available and registered.
> 
> Fixes: 9490f01e2471 ("clk: scpi: add support for cpufreq virtual device")
> Reported-by: Micha? Zegan <webczat_200@poczta.onet.pl>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---

Applied to clk-next

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
