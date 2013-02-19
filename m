From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Mon, 18 Feb 2013 16:40:16 -0800 (PST)
Subject: [PATCH 2/4] ARM: mach-shmobile: r8a7779: add SATA support
In-Reply-To: <CANqRtoRdTMN=KgP4CypF+mpTN4HOSKrDAoq2pr4Pd3t-zarSjA@mail.gmail.com>
References: <201302170143.36052.sergei.shtylyov@cogentembedded.com>
 <874nhao1nx.wl%kuninori.morimoto.gx@renesas.com>
 <51223584.5080709@cogentembedded.com>
 <CANqRtoRdTMN=KgP4CypF+mpTN4HOSKrDAoq2pr4Pd3t-zarSjA@mail.gmail.com>
Message-ID: <87ehgdf85y.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Sergei, Magnus, Simon

> >>>   static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst
> >>> = {
> >>> +       OF_DEV_AUXDATA("renesas,rcar-sata", 0xfc600000, "sata_rcar",
> >>> NULL),
> >
> >
> >> ??
> >> Is this settings really required for DT ??
> >
> >
> >    Yes, TTBOMK, it's the last resort measure used in exctly this case.
> 
> Well, I have to agree with Morimoto-san here. Other vendors may chose
> to use AUXDATA to map clocks, and I believe it makes sense in the case
> of adding platform data as a workaround during transition to full DT
> support. But for simply mapping clocks please follow the same style as
> we have done so far, which is what Morimoto-san pointed out:
> 
> CLKDEV_DEV_ID("fc600000.sata_rcar", &mstp_clks[MSTP115]),
> 
> Also, I don't think SATA is needed as an early device so it should be
> enough to register it late as a regular platform device. =)

BTW, Sergei, which branch are you using for R-Car H1 DT booting ?
I'm not sure detail, but, I guess R-Car H1 DT detection needs
simon's latest branch.
If you are using old branch, DT detection will be failed ?

Simon, is my comment correct ?

Best regards
---
Kuninori Morimoto
