From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Nov 2014 12:12:15 +0000
Subject: [PATCH v3 3/5] arm64: dts: Add support for Spreadtrum SC9836 SoC
 in dts and Makefile
In-Reply-To: <20141127115042.GE857@leverpostej>
References: <Sharkl64-v3>
 <1416917818-10506-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1416917818-10506-4-git-send-email-chunyan.zhang@spreadtrum.com>
 <20141127115042.GE857@leverpostej>
Message-ID: <20141127121214.GF11511@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 11:50:43AM +0000, Mark Rutland wrote:
> On Tue, Nov 25, 2014 at 12:16:56PM +0000, Chunyan Zhang wrote:
> > +
> > +       timer {
> > +               compatible = "arm,armv8-timer";
> > +               interrupts = <1 13 0xff01>,
> > +                            <1 14 0xff01>,
> > +                            <1 11 0xff01>,
> > +                            <1 10 0xff01>;
> > +               clock-frequency = <26000000>;
> 
> Please remove the clock-frequency property. Your FW should initialise
> CNTFRQ_EL0 on all CPUs (certainly PSCI 0.2 requires that you do this).

Since this comes up regularly, I think we need a dev_warn() in the arch
timer driver when CONFIG_ARM64.

-- 
Catalin
