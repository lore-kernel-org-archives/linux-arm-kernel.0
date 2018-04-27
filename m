From: davem@davemloft.net (David Miller)
Date: Fri, 27 Apr 2018 11:23:21 -0400 (EDT)
Subject: [PATCH net v2 0/2] net: mvpp2: Fix hangs when starting some
 interfaces on 7k/8k
In-Reply-To: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
References: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
Message-ID: <20180427.112321.1722845947622725407.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 25 Apr 2018 20:21:15 +0200

> Armada 7K / 8K clock management has recently been reworked, see :
> 
> commit c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
> 
> I have been experiencing overall system hangs on MacchiatoBin when starting
> the eth1 interface since then. It turns out some clocks dependencies were
> missing in the PPv2 and xmdio driver, the clock rework made this visible.
> 
> This is the V2 series, that adds support for the missing 'MG Core clock' in
> mvpp2, and fixes an issue with the error path for the axi_clk.
> 
> Thanks to Gregory Clement for finding the root cause of this bug.
> 
> V2 : Remove all DT patches from this series, they will be merged through
>      the mvebu tree.

Series applied, thank you.
