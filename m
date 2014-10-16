From: Li.Xiubo@freescale.com (Li.Xiubo at freescale.com)
Date: Thu, 16 Oct 2014 02:30:31 +0000
Subject: [PATCH v3] ARM: ls1021a: add gating clocks to IP blocks.
In-Reply-To: <20140925085403.GG6405@dragon>
References: <1411476275-9164-1-git-send-email-Li.Xiubo@freescale.com>
 <20140925085403.GG6405@dragon>
Message-ID: <458d4826bf9a4d678480ae3d9660380e@BY2PR0301MB0613.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

[...]
> > +						DCFG_CCSR_DEVDISR1,
> > +						ls1021a_clk_shift(0));
> 
> I think we can ignore the 80 columns warning and put these on one line
> to make the code a bit easier to read.
> 

Yes, it looks better, but in the FSL's internal Gerrit it will be a little
Harder to merge this patch in SDK, the Jenkins will check this and then return
failure.


Thanks,

BRs
Xiubo

> > +	clks[LS1021A_CLK_ESDHC_EN] = ls1021a_clk_gate("esdhc_en", "dummy",
> > +						DCFG_CCSR_DEVDISR1,
> > +						ls1021a_clk_shift(2));
[...]
