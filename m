From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 30 Jan 2012 11:13:48 +0800
Subject: Pinmux bindings proposal V2
In-Reply-To: <CAPnjgZ2EkvTMsOkWyf4pfwRpvcvYs=WaKy5Gi8fdkAUQmvt=ig@mail.gmail.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF1780DAB4CE@HQMAIL01.nvidia.com>
 <CAPnjgZ3Xhebn1x1A-Vdy78DWbDd=cp0AK6tL-R1SRzS4GdF97g@mail.gmail.com>
 <20120127022111.GK29812@atomide.com>
 <CAPnjgZ2EkvTMsOkWyf4pfwRpvcvYs=WaKy5Gi8fdkAUQmvt=ig@mail.gmail.com>
Message-ID: <20120130031346.GD10470@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2012 at 07:43:36AM -0800, Simon Glass wrote:
...
> The cost of the pmx at dta node is about 12 bytes for the header (it
> depends on the length of the name), and each of the properties above
> is 16 bytes. So in total this node is 76 bytes. If we have 250 pins
> being muxed as Tegra3 then this is about 20KB (including a bit of
> slack for longer names). My point about being able to 'optimise out'
> some of these remains, though, but probably not for the kernel.
> 
> Stephen's 'mux' property uses 12 bytes plus 8 bytes per pin/group (I
> am removing the prefixes):
> 
>                        mux =
>                                <PG_DTA   MUX_SDIO1>
>                                <PG_DTD   MUX_SDIO1>;
> 
> so 28 bytes. What I proposed would use (12 + 2 * 16) per pin/group, or
> 44 bytes (60% bigger):
> 
It's not only about size but also run-time tree travelling efficiency.
Your proposal requires every single pin show as a node in device tree.
Looking at these for_each_node_by_*() APIs in include/linux/of.h, you
might agree we should avoid bloating device tree with so many nodes.

-- 
Regards,
Shawn
