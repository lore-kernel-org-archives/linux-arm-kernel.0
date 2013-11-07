From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 07 Nov 2013 13:15:26 +0100
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <871u2s65kz.wl%kuninori.morimoto.gx@renesas.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <87zjpggalc.wl%kuninori.morimoto.gx@renesas.com>
 <871u2s65kz.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <3394178.9T7q17vczr@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Morimoto-san,

On Wednesday 06 November 2013 23:20:32 Kuninori Morimoto wrote:
> Hi Laurent again
> 
> > In my SuperH experience, CPG clock divier has same pattern.
> > In H2's SDCKCR register, SDHFC and SD0FC looks different.
> > But, the real different is only enabled bit area,
> > the value is same.
> > You can find same pattern on FRQCRB register too,
> > and, you can find same pattern on M2.
> > 
> > I guess FRQCRB/SDHFC can share code if it has mask.
> > This idea was used on R-Mobile series on div4.
> > (ex clock-sh73a0.c :: div4_clks)
> 
> I talked it with Magnus, and I understand your headache.
> I can agree about your approach now.
> 
> But, I guess H2 and M2 are very similar SoC.
> and I don't want too many clock-${SoC} files.
> Is it possible to share code like clk-gen2.c ?

Sure, if the hardware is very similar, it makes sense to share code. I've had 
a quick look at the M2 documentation, and it seems to be indeed mostly 
identical to H2. Only a couple of clocks are missing, and a new GPU clock 
register is documented. As the GPU clock is mentioned in the H2 documentation 
as being programmable I would assume that the GPU clock register exists and is 
identical in H2 but has been forgotten in the documentation.

We should probably extend clock-r8a7790.c with M2 support and rename it to 
clock-rcar-gen2.c before pushing it to mainline. Would you like to submit a 
patch ? :-)

-- 
Regards,

Laurent Pinchart
