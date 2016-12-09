From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 9 Dec 2016 00:33:02 +0000
Subject: [PATCH 2/3] ASoC: simple-card: use devm_get_clk_from_child()
In-Reply-To: <20161209002837.GE5423@codeaurora.org>
References: <874m2jvtmw.wl%kuninori.morimoto.gx@renesas.com>
 <871sxnvtkp.wl%kuninori.morimoto.gx@renesas.com>
 <20161208220942.GO5423@codeaurora.org>
 <877f7aymxu.wl%kuninori.morimoto.gx@renesas.com>
 <20161209002837.GE5423@codeaurora.org>
Message-ID: <871sxiymca.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Stephen

> > Documentation/devicetree/bindings/sound/simple-card.txt
> > explains 1st of_clk_get will be used as "if needed",
> > 2nd of_clk_get will be used as "not needed pattern".
> > 1st pattern will use specific clock, 2nd pattern will use
> > "cpu" or "codec" clock.
> > 2nd one was added by someone (I forgot), and many driver is
> > based on this feature.
> > 
> 
> Can you point to some dts file in the kernel that falls into the
> devm_get_clk_from_child(dev, dai_of_node, NULL) part?

How about this ?

linux/arch/arm/boot/dts/r8a7790-lager.dts :: rsnd_ak4643
