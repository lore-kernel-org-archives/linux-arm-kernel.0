From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 20 Jun 2016 17:11:51 -0700
Subject: [PATCH 2/8] tty: serial: fsl_lpuart: support suspend/resume
In-Reply-To: <AF70EE92-9B41-4ECE-AB5F-E829E611B7C6@agner.ch>
References: <20160609151039.20817-1-bhuvanchandra.dv@toradex.com>
 <20160609151039.20817-3-bhuvanchandra.dv@toradex.com>
 <20160611140341.GT20243@tiger>
 <cdeb3e9b-92c5-77d9-78ec-3af3954e8e16@toradex.com>
 <AF70EE92-9B41-4ECE-AB5F-E829E611B7C6@agner.ch>
Message-ID: <20160621001151.GE1521@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13, Stefan Agner wrote:
> 
> 
> On June 13, 2016 5:18:19 PM PDT, Bhhuvanchandra DV <bhuvanchandra.dv@toradex.com> wrote:
> >Hi Shawn,
> >
> >On 06/11/2016 02:03 PM, Shawn Guo wrote:
> >
> >> On Thu, Jun 09, 2016 at 08:40:33PM +0530, Bhuvanchandra DV wrote:
> >>> From: Stefan Agner <stefan@agner.ch>
> >>>
> >>> In order to allow wake support in STOP sleep mode, clocks are
> >>> needed. Use imx_clk_gate2_cgr to disable automatic clock gating
> >>> in low power mode STOP. This allows to enable wake by UART using:
> >>> echo enabled > /sys/class/tty/ttyLP0/power/wakeup
> >>>
> >>> However, if wake is not enabled, the driver should disable the
> >>> clocks explicitly to save power.
> >>>
> >>> Signed-off-by: Stefan Agner <stefan@agner.ch>
> >>> ---
> >>>   drivers/clk/imx/clk-vf610.c     | 12 ++++++------
> >> Please send clock driver changes in a separate patch.
> 
> The changes are dependet on each other, hence I put it in a single patch. But since it is a new feature it shouldn't really matter...
> 
> >
> >How about splitting this patchset to two? few patches are having minor
> >fixes and the few patches might need some review and discussions.
> >May be some thing like DMA fixes and the other minor fixes.
> 
> I don't think that splitting up the patchset is necessary, with the current order it is possible to pick up the fixes independently...
> 

I think the main problem is clk and tty subsystems are modified
in the same patch here. Did you want an ack from clk maintainers
here or will the patch be split so we can take the clk part
through clk tree?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
