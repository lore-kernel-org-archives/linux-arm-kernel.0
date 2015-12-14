From: horms@verge.net.au (Simon Horman)
Date: Mon, 14 Dec 2015 10:47:41 +0900
Subject: [PATCH/RFC 05/19] ARM: shmobile: r8a7793: add MSTP10 clocks to
 device tree
In-Reply-To: <87oadtkfrw.wl%kuninori.morimoto.gx@renesas.com>
References: <1449802376-11301-1-git-send-email-horms+renesas@verge.net.au>
 <1449802376-11301-6-git-send-email-horms+renesas@verge.net.au>
 <87oadtkfrw.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20151214014735.GA13945@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 14, 2015 at 01:00:59AM +0000, Kuninori Morimoto wrote:
> 
> Hi Simon
> 
> > Instantiate MSTP10 clocks in r8a7793 device tree.
> > 
> > Based on similar work for the r8a7791 by Kuninori Morimoto.
> > 
> > Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> (snip)
> > +		mstp10_clks: mstp10_clks at e6150998 {
> > +			compatible = "renesas,r8a7793-mstp-clocks", "renesas,cpg-mstp-clocks";
> > +			reg = <0 0xe6150998 0 4>, <0 0xe61509a8 0 4>;
> 
> I wonder does r8a7793 use mstp driver ? not mssr ?
> Because RFC ?

My main motivation is that it follow the pattern already used
for other clocks in the same file. I believe all the Renesas ARM32
DTS/DTSI files are currently using mssr. Perhaps we should
come up with a plan to migrate some or all of them to mstp.
