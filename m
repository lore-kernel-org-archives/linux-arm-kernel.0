From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 17 Jun 2016 02:14:50 +0000
Subject: [PATCH 07/13] ARM: dts: r8a7792: initial SoC device tree
In-Reply-To: <87eg80d1m9.wl%kuninori.morimoto.gx@renesas.com>
References: <13205049.n7pM8utpHF@wasted.cogentembedded.com>
 <2539026.OyU5nvpxa6@wasted.cogentembedded.com>
 <20160601005751.GG20527@verge.net.au>
 <fdab2628-60bd-c41b-296b-38cd71a6c5da@cogentembedded.com>
 <CAMuHMdUkOpEp+YCbZVZppdN4C7KKpDS9_gEuXi_WKZXM9YHgEQ@mail.gmail.com>
 <ab5e3a98-7ff2-dc8f-d255-f6da26f43527@cogentembedded.com>
 <20160610010245.GA10152@verge.net.au>
 <8efb1c7e-5463-2556-744c-d327886d92d4@cogentembedded.com>
 <CAMuHMdUK=y2kZY1kA97QpCDyUZXFejpXTpO9ZVNQoBfDNoRgfg@mail.gmail.com>
 <1b9a4cf4-1101-ccbf-772b-49b8a689a1b6@cogentembedded.com>
 <CAMuHMdV6f5ZzPxySzCgi7L+Sr1_4Ph1sLLyQ_j-sJ0tmBOvrHg@mail.gmail.com>
 <87eg80d1m9.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <87a8iko9dm.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Geert

> > Right, I had forgotten about that.
> > Fortunately the clk-rcar-gen2 driver has a sane failure mode for this case ;-)
> > 
> > it seems the RCAN clock can just be modeled as a fixed clock. However,
> > its divider value isn't clear to me, as 15.9 MHz cannot be generated from PLL1
> > using an integer divider. Morimoto-san, can you please ask for clarification?
> 
> OK.
> Now, I asked to HW team about that.
> Please wait.

RCAN divider is fixed for 1/49

PLL1 (= 1560MHz) 
  -> 1/2 (= 780MHz)
    -> RCAN divider 1/49 (= 15.9183..MHz)

Is this clear for you ?
