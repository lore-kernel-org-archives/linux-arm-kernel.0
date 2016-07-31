From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sun, 31 Jul 2016 21:18:12 +0800
Subject: [PATCH 2/3] phy: sun4i: add support for A64 usb phy
In-Reply-To: <CABHD4K9awH3moyCktEq3acYN=GS74nhThuFDsYt10UTqOHSw3Q@mail.gmail.com>
References: <20160731112536.4625-1-icenowy@aosc.xyz>
 <20160731112536.4625-2-icenowy@aosc.xyz>
 <CABHD4K9awH3moyCktEq3acYN=GS74nhThuFDsYt10UTqOHSw3Q@mail.gmail.com>
Message-ID: <48051469971092@web25g.yandex.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



31.07.2016, 20:39, "Amit Tomer" <amittomer25@gmail.com>:
> Hello ,
>
>> ?@@ -264,6 +266,12 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>> ?????????????????val = readl(phy->pmu + REG_PMU_UNK_H3);
>> ?????????????????writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
>> ?????????} else {
>> ?+ /* A64 needs also this unknown bit */
>> ?+ if (data->cfg->type == sun50i_a64_phy) {
>> ?+ val = readl(phy->pmu + REG_PMU_UNK_H3);
>> ?+ writel(val & ~2, phy->pmu + REG_PMU_UNK_H3);
>> ?+ }
>> ?+
>
> This bit is also set for H3, shall we reuse it or we should enclose it
> in else-if part ?
To be honest, I don't know which format is better...
I'm not so familiar about the tradition of Linux kernel coding style...
>
> Thanks
> Amit.
