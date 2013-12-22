From: olof@lixom.net (Olof Johansson)
Date: Sun, 22 Dec 2013 11:56:19 -0800
Subject: [PATCH v6 0/2] ARM: mach-moxart: add MOXA ART SoC support
In-Reply-To: <1387371526-15309-1-git-send-email-jonas.jensen@gmail.com>
References: <1387371526-15309-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20131222195619.GG9144@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 01:58:44PM +0100, Jonas Jensen wrote:
> Thanks for the replies!
> 
> This should tick the boxes on feedback except for one detail
> on the fixed rate clock:
> 
> Moving fixed-clock "ref12" from .dtsi to .dts proved problematic
> for other clocks, this is why ref12 is still in SoC.
> 
> My assertion is that "fixed-clock" clocks are probed later when
> placed in .dts (see diff and boot log below).
> of_clk_get() from clk_pll in .dtsi fails, i.e. fixed-clock ref12
> is not added as a provider in time before clk_pll loads.

Argh, I didn't see this version before I applied v5. So I dropped v5 and
replaced with v6.


-Olof
