From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 17 Dec 2012 23:14:46 +0800
Subject: [PATCH 4/4] FEC: Add time stamping code and a PTP hardware clock
In-Reply-To: <CAHrpEqTVuSR_-Tpdzb98=VJbg7grSFvSQ9xA6mPsHpGb7RvNCg@mail.gmail.com>
References: <1351657531-25989-1-git-send-email-Frank.Li@freescale.com>
 <20121217091345.GA753@pengutronix.de>
 <CAHrpEqTVuSR_-Tpdzb98=VJbg7grSFvSQ9xA6mPsHpGb7RvNCg@mail.gmail.com>
Message-ID: <20121217151445.GA17907@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sascha,

On Mon, Dec 17, 2012 at 10:48:31PM +0800, Frank Li wrote:
> > I don't know how to continue from here. Since the whole patch doesn't
> > seem to reviewed very much I tend to say we should revert it for now and
> > let Frank redo it for the next merge window.
> >
> > Other opinions?
> 
> Can we just disable CONFIG_FEC_PTP defaut instead of revert whole patch?
> 
To be clear, the following is what Frank meant.  Since Frank is out of
office for some time, I will send this immediate fix to David, if you
are fine with it.

Shawn

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index 5ba6e1c..d1edb2e 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -96,7 +96,6 @@ config FEC_PTP
        bool "PTP Hardware Clock (PHC)"
        depends on FEC && ARCH_MXC
        select PTP_1588_CLOCK
-       default y if SOC_IMX6Q
        --help---
          Say Y here if you want to use PTP Hardware Clock (PHC) in the
          driver.  Only the basic clock operations have been implemented.
