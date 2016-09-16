From: voker57@gmail.com (Iaroslav Gridin)
Date: Fri, 16 Sep 2016 20:38:01 +0300
Subject: [PATCH] ARM: dts: msm8974: Add definitions for QCE & cryptobam
In-Reply-To: <20160915211842.GB5431@hector.attlocal.net>
References: <20160830153740.13275-1-voker57@gmail.com>
 <20160915211842.GB5431@hector.attlocal.net>
Message-ID: <20160916173800.r264xg5wqmer77wr@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 04:18:42PM -0500, Andy Gross wrote:
 
> Actually, on thinking about this more, the bam block itself only requires the
> single clock.  The peripheral it is attached to has to keep its sanity during
> the duration of the transfer (crypto).  The crypto requires 3 clocks, one of
> which is the same clk the bam requires.
> 
> You can access the BAM registers with the bam_clk only, correct?

Not preparing bam_clk degrades QCE performance about 3x, though.
