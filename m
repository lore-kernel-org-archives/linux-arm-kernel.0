From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 17 Dec 2013 11:21:30 -0800
Subject: [PATCH v2 3/9] clocksource/cadence_ttc: Store timer frequency in
 driver data
In-Reply-To: <1385514296-26702-4-git-send-email-soren.brinkmann@xilinx.com>
References: <1385514296-26702-1-git-send-email-soren.brinkmann@xilinx.com>
 <1385514296-26702-4-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <5cff3201-db97-4061-a686-bf79ac17d4fe@CO1EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On Tue, Nov 26, 2013 at 05:04:50PM -0800, Soren Brinkmann wrote:
> It is not allowed to call clk_get_rate() from interrupt context. To
> avoid such calls the timer input frequency is stored in the driver's
> data struct which makes it accessible to the driver in any context.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I doubt that we'll resolve all issues with this series before the
holidays or even the next merge window. Could you take this patch into
your tree for 3.14? It is not directly related to the cpufreq work and
fixes an actual issue that triggers a kernel WARN under some condition
(I missed preserving the details and the trace). That would take the
easy stuff out of the way and we can focus on the more controversial
changes.

	Thanks,
	S?ren
