From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 10 Feb 2016 00:32:48 +0000
Subject: [PATCH 5/5] ARM: dts: r8a7794 add sound support
In-Reply-To: <56BA4B3D.1030301@cogentembedded.com>
References: <4253511.vvGjIdOnb6@wasted.cogentembedded.com>
 <2179456.HznTXDfKhZ@wasted.cogentembedded.com>
 <20160209195054.GA14008@verge.net.au>
 <56BA4B3D.1030301@cogentembedded.com>
Message-ID: <877fidtnm6.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi

> >> Define the generic R8A7794 part of  the sound device node.
> >> This sound device  is a complex one and comprises the Audio Clock Generator
> >> (ADG), Sampling Rate Converter Unit (SCU), Serial Sound Interface [Unit]
> >> (SSI[U]), and Audio DMAC-Peripheral-Peripheral.
> >> It is up  to the board file to enable the device.
> >>
> >> This patch is based on the R8A7791 sound work by Kuninori Morimoto.
> >>
> >> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> >>
> >> ---
(snip)
> > My reading of the documentation is that src0, 7, 8 and 9 are not
> > present on the r8a7794. I am referring to Figure 38.1b or r1.02 of
> > the R-Car Gen2 User's Manual.
> 
>    Indeed, thank you for the timely comment (I'm working on the series
> respin)! However, table 7A.12 still lists the SRC0/7/8/9 clocks for
> R8A7794, table 11.1 still lists SRC0/7/8/9 interrupts for R8A7794, and
> table 43.4 still lists SRC0/7/8/9 MID+RID for R8A7794 -- go figure...

Oops, current rsnd driver is assuming that DT has all channels.
This means it doesn't check src number itself.

Can you add src0, 7, 8, 9 with "non exist" comment ?
Otherwise, we need to modify driver, but I'm not sure how this assumption is deep.

Best regards
---
Kuninori Morimoto
