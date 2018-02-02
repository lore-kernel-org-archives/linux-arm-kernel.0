From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 2 Feb 2018 08:47:15 +0800
Subject: [PATCH V2 2/2] cpufreq: imx6q: add 696MHz operating point for
 i.mx6ul
In-Reply-To: <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
References: <1515235360-1628-1-git-send-email-Anson.Huang@nxp.com>
 <1515235360-1628-2-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180202004713.GC20833@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 06, 2018 at 06:42:40PM +0800, Anson Huang wrote:
> Add 696MHz operating point for i.MX6UL, only for those
> parts with speed grading fuse set to 2b'10 supports
> 696MHz operating point, so, speed grading check is also
> added for i.MX6UL in this patch, the clock tree for each
> operating point are as below:
> 
> 696MHz:
>     pll1                       696000000
>        pll1_bypass             696000000
>           pll1_sys             696000000
>              pll1_sw           696000000
>                 arm            696000000
> 528MHz:
>     pll2                       528000000
>        pll2_bypass             528000000
>           pll2_bus             528000000
>              ca7_secondary_sel 528000000
>                 step           528000000
>                    pll1_sw     528000000
>                       arm      528000000
> 396MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            396000000
> 198MHz:
>     pll2_pfd2_396m             396000000
>        ca7_secondary_sel       396000000
>           step                 396000000
>              pll1_sw           396000000
>                 arm            198000000
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
