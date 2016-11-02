From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 1 Nov 2016 17:27:54 -0700
Subject: [PATCH] clk: qoriq: Don't allow CPU clocks higher than starting
 value
In-Reply-To: <1476729743-15563-1-git-send-email-oss@buserror.net>
References: <1476729743-15563-1-git-send-email-oss@buserror.net>
Message-ID: <20161102002754.GF16026@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17, Scott Wood wrote:
> The boot-time frequency of a CPU is considered its rated maximum, as we
> have no other source of such information.  However, this was previously
> only used for chips with 80% restrictions on secondary PLLs.  This
> usually wasn't a problem because most chips/configs boot with a divider
> of /1, with other dividers being used only for dynamic frequency
> reduction.  However, at least one config (LS1021A at less than 1 GHz)
> uses a different divider for top speed.  This was causing cpufreq to set
> a frequency beyond the chip's rated speed.
> 
> This is fixed by applying a 100%-of-initial-speed limit to all CPU PLLs,
> similar to the existing 80% limit that only applied to some.
> 
> Signed-off-by: Scott Wood <oss@buserror.net>
> Cc: stable at vger.kernel.org
> ---

All silence, so I applied to clk-fixes because presumably this is
some sort of badness we need to fix quickly.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
