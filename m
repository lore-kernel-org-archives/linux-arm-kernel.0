From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 5 Sep 2016 10:34:51 +0800
Subject: [PATCH v4] ARM: imx: Added perf functionality to mmdc driver
In-Reply-To: <20160831170029.27756-1-zhengyu.shen@nxp.com>
References: <20160831170029.27756-1-zhengyu.shen@nxp.com>
Message-ID: <20160905023451.GH25778@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 31, 2016 at 12:00:29PM -0500, Zhengyu Shen wrote:
> MMDC is a multi-mode DDR controller that supports DDR3/DDR3L x16/x32/x64
> and LPDDR2 two channel x16/x32 memory types. MMDC is configurable, high
> performance, and optimized. MMDC is present on i.MX6 Quad and i.MX6
> QuadPlus devices, but this driver only supports i.MX6 Quad at the moment.
> MMDC provides registers for performance counters which read via this
> driver to help debug memory throughput and similar issues.
> 
> $ perf stat -a -e mmdc/busy-cycles/,mmdc/read-accesses/,mmdc/read-bytes/,mmdc/total-cycles/,mmdc/write-accesses/,mmdc/write-bytes/ dd if=/dev/zero of=/dev/null bs=1M count=5000
> Performance counter stats for 'dd if=/dev/zero of=/dev/null bs=1M count=5000':
> 
>          898021787      mmdc/busy-cycles/
>           14819600      mmdc/read-accesses/
>             471.30 MB   mmdc/read-bytes/
>         2815419216      mmdc/total-cycles/
>           13367354      mmdc/write-accesses/
>             427.76 MB   mmdc/write-bytes/
> 
>        5.334757334 seconds time elapsed
> 
> Signed-off-by: Zhengyu Shen <zhengyu.shen@nxp.com>
> Signed-off-by: Frank Li <frank.li@nxp.com>

I'm fine with this version, but still want a Reviewed-by tag from Mark
to apply the patch.

Shawn
