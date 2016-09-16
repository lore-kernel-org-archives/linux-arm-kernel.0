From: andy.gross@linaro.org (Andy Gross)
Date: Fri, 16 Sep 2016 13:50:12 -0500
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <20160916173800.r264xg5wqmer77wr@localhost>
References: <20160830153740.13275-1-voker57@gmail.com>
 <20160915211842.GB5431@hector.attlocal.net>
 <20160916173800.r264xg5wqmer77wr@localhost>
Message-ID: <20160916185012.GC5431@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2016 at 08:38:01PM +0300, Iaroslav Gridin wrote:
> On Thu, Sep 15, 2016 at 04:18:42PM -0500, Andy Gross wrote:
>  
> > Actually, on thinking about this more, the bam block itself only requires the
> > single clock.  The peripheral it is attached to has to keep its sanity during
> > the duration of the transfer (crypto).  The crypto requires 3 clocks, one of
> > which is the same clk the bam requires.
> > 
> > You can access the BAM registers with the bam_clk only, correct?
> 
> Not preparing bam_clk degrades QCE performance about 3x, though.

If the CE2_CLK is the only required clk, that makes it the "bam_clk".  I see the
crypto requires getting all three clocks: AXI (bus), AHB (iface), and CE2 (core)

If the crypto is active during DMA transfers, which it has to be, then the
performance shouldn't degrade due to the BAM not preparing the AHB.

Regards,

Andy
