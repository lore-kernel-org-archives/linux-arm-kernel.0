From: nm@ti.com (Nishanth Menon)
Date: Wed, 19 Jun 2013 08:56:30 -0500
Subject: [PATCHv2 10/11] ARM: dts: omap4 clock data
In-Reply-To: <51C1B707.5090603@ti.com>
References: <1371647942-4811-1-git-send-email-t-kristo@ti.com>
 <1371647942-4811-11-git-send-email-t-kristo@ti.com>
 <20130619133022.GA30364@kahuna> <51C1B707.5090603@ti.com>
Message-ID: <20130619135629.GA2236@kahuna>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16:49-20130619, Tero Kristo wrote:
> On 06/19/2013 04:30 PM, Nishanth Menon wrote:
> >On 16:19-20130619, Tero Kristo wrote:
> >[...]
> >>+
> >>+/*
> >>+ * clocks specific to omap4460
> >>+ */
> >>+/*
> >>+ * clocks specific to omap4430
> >>+ */
> >>+/*
> >>+ * clocks common to omap44xx
> >>+ */
> >could be dropped?
> 
> Same.
> 
> >
> >btw, are we differentiating 4430 and 4460?A
> >Example:
> >bandgap_fclk in 4430
> >Vs
> >div_ts_ck, bandgap_ts_fclk in 4460?
> 
> Both nodes are available for both SoCs as of now. Driver should
> differentiate which clock node to use though. Added Eduardo for
> commenting this part, maybe we should add a couple of entries to the
> list in cclock44xx_data.c...?
How about this:
we do have 443x.dtsi and 4460.dtsi -> add the corresponding clock nodes
there?

ideally, driver should just do devm_clk_get and should not worry about
what SoC revision it is running on.

-- 
Regards,
Nishanth Menon
