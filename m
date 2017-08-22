From: horms@verge.net.au (Simon Horman)
Date: Tue, 22 Aug 2017 10:07:35 +0200
Subject: [PATCH ] ARM: dts: iwg20d-q7: Add chosen node
In-Reply-To: <1503075488-44304-1-git-send-email-biju.das@bp.renesas.com>
References: <1503075488-44304-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <20170822080735.GH30838@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 18, 2017 at 05:58:08PM +0100, Biju Das wrote:
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> ---
> This patch tested against renesas-dev tag renesas-devel-20170815-v4.13-rc5

Thanks, I have applied this for v4.15.

There was some fuzz when applying this patch.
Please check that it is correct when I have pushed today's devel tag to
the renesas tree.

> 
>  arch/arm/boot/dts/r8a7743-iwg20d-q7.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> index 081af01..305a6a1 100644
> --- a/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> +++ b/arch/arm/boot/dts/r8a7743-iwg20d-q7.dts
> @@ -19,6 +19,11 @@
>  		serial0 = &scif0;
>  		ethernet0 = &avb;
>  	};
> +
> +	chosen {
> +		bootargs = "ignore_loglevel rw root=/dev/nfs ip=dhcp";
> +		stdout-path = "serial0:115200n8";
> +	};
>  };
>  
>  &pfc {
> -- 
> 1.9.1
> 
