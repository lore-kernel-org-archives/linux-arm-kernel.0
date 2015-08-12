From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 12 Aug 2015 09:49:54 +0800
Subject: [PATCH v4 0/4] clk: hisilicon: support stub clock
In-Reply-To: <20150812003817.GI26614@codeaurora.org>
References: <1438673249-6051-1-git-send-email-leo.yan@linaro.org>
 <20150812003817.GI26614@codeaurora.org>
Message-ID: <20150812014954.GA6215@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Tue, Aug 11, 2015 at 05:38:17PM -0700, Stephen Boyd wrote:
> On 08/04, Leo Yan wrote:
> > This series adds support for hisilicon stub clock driver. On hi6220,
> > the bootloader needs load the firmware image and set info for OPPs;
> > after run into kernel, the stub clock driver is used to communicate
> > w/t firmware for cpu dynamic frequency scaling.
> > 
> > In patch series v1/v2, the stub clock driver simply writes request in
> > sram and send ipc to firmware; For patch series v3, the firmware has
> > been upgraded to use mailbox, so stub clock driver will call standard
> > mailbox APIs to request mailbox channel and send message to firmware.
> > 
> > Patch 4 adds stub clock node into dts and it references mailbox with
> > phandle, so patch 4 will depend on mailbox driver's patch series [1].
> > These patches have been tested on 96board hikey and is used by cpufreq
> > driver.
> 
> The To: list is everyone, so I'm not sure who is supposed to
> apply these patches. I'd like to take patches 1, 2, and 3 through
> the clk tree though.

Thanks, you could take first three patches. For patch 4, i will
re-send it after mailbox driver's patches have been merged.

Wei Xu, is this okay for you?

Thanks,
Leo Yan
