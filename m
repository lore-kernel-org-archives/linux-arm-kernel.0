From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 Mar 2013 10:22:08 +0800
Subject: [PATCH V3 3/3] ARM: imx: enable RBC to support anatop LPM mode
In-Reply-To: <1363877886-26538-1-git-send-email-b20788@freescale.com>
References: <1363877886-26538-1-git-send-email-b20788@freescale.com>
Message-ID: <20130321022206.GB23109@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 21, 2013 at 10:58:06AM -0400, Anson Huang wrote:
> RBC is to control whether some ANATOP sub modules
> can enter lpm mode when SOC is into STOP mode, if
> RBC is enabled and PMIC_VSTBY_REQ is set, ANATOP
> will have below behaviors:
> 
> 1. Digital LDOs(CORE, SOC and PU) are bypassed;
> 2. Analog LDOs(1P1, 2P5, 3P0) are disabled;
> 
> As the 2P5 is necessary for DRAM IO pre-drive in
> STOP mode, so we need to enable weak 2P5 in STOP
> mode when 2P5 LDO is disabled.
> 
> For RBC settings, there are some rules as below
> due to hardware design:
> 
> 1. All interrupts must be masked during operating
>    RBC registers;
> 2. At least 2 CKIL(32K) cycles is needed after the
>    RBC setting is changed.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
