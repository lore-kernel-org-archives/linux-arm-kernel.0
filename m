From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 06 Nov 2013 23:20:32 -0800 (PST)
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <87zjpggalc.wl%kuninori.morimoto.gx@renesas.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <2775658.fxp7sbhy9u@avalon>
 <8738na1csg.wl%kuninori.morimoto.gx@renesas.com>
 <1550251.naXFpxhfMk@avalon>
 <87zjpggalc.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <871u2s65kz.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Laurent again

> In my SuperH experience, CPG clock divier has same pattern.
> In H2's SDCKCR register, SDHFC and SD0FC looks different.
> But, the real different is only enabled bit area,
> the value is same.
> You can find same pattern on FRQCRB register too,
> and, you can find same pattern on M2.
> 
> I guess FRQCRB/SDHFC can share code if it has mask.
> This idea was used on R-Mobile series on div4.
> (ex clock-sh73a0.c :: div4_clks)

I talked it with Magnus, and I understand your headache.
I can agree about your approach now.

But, I guess H2 and M2 are very similar SoC.
and I don't want too many clock-${SoC} files.
Is it possible to share code like clk-gen2.c ?

Best regards
---
Kuninori Morimoto
