From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Wed, 18 Dec 2013 09:26:10 -0800
Subject: [PATCH v6 0/2] ARM: mach-moxart: add MOXA ART SoC support
In-Reply-To: <1387371526-15309-1-git-send-email-jonas.jensen@gmail.com>
References: <1387371526-15309-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <0e3d482f-0b7c-4654-bb75-d6aa3e209fd7@CH1EHSMHS008.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jonas,

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

I haven't looked into the details, but is of_clk_get_parent_name() an
alternative? That function does purely rely on DT data to obtain a name
of a clock which may enable to register your PLL? Then probing oder
wouldn't matter anymore.

	S?ren
