From: olof@lixom.net (Olof Johansson)
Date: Wed, 24 Sep 2014 10:32:58 -0700
Subject: [PATCH] ARM: hisi: Fix platmcpm compilation when ARMv6 is selected
In-Reply-To: <542289E4.6000901@hisilicon.com>
References: <542289E4.6000901@hisilicon.com>
Message-ID: <20140924173258.GB18667@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 05:07:48PM +0800, Wei Xu wrote:
> When compiling with "ARCH=arm" and "allmodconfig",
> with commit: 9cdc99919a95e8b54c1998b65bb1bfdabd47d27b [2/7] ARM: hisi: enable MCPM implementation
> we will get:
> 
>    /tmp/cc6DjYjT.s: Assembler messages:
>    /tmp/cc6DjYjT.s:63: Error: selected processor does not support ARM mode `ubfx r1,r0,#8,#8'
>    /tmp/cc6DjYjT.s:761: Error: selected processor does not support ARM mode `isb '
>    /tmp/cc6DjYjT.s:762: Error: selected processor does not support ARM mode `dsb '
>    /tmp/cc6DjYjT.s:769: Error: selected processor does not support ARM mode `isb '
>    /tmp/cc6DjYjT.s:775: Error: selected processor does not support ARM mode `isb '
>    /tmp/cc6DjYjT.s:776: Error: selected processor does not support ARM mode `dsb '
>    /tmp/cc6DjYjT.s:795: Error: selected processor does not support ARM mode `isb '
>    /tmp/cc6DjYjT.s:801: Error: selected processor does not support ARM mode `isb '
>    /tmp/cc6DjYjT.s:802: Error: selected processor does not support ARM mode `dsb '
> 
> Fix platmcpm compilation when ARMv6 is selected.
> 
> Signed-off-by: Wei Xu <xuwei5@hisilicon.com>

Thanks, applied.


-Olof
