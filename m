From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Fri, 21 Mar 2014 22:23:20 +0100
Subject: [PATCH] ARM: i.MX6: update KSZ9031 phy fixup
In-Reply-To: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
References: <1395421687-12934-1-git-send-email-hchaumette@adeneo-embedded.com>
Message-ID: <20140321222320.14370739@e6520eb>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hubert,

Le Fri, 21 Mar 2014 18:08:07 +0100,
Hubert Chaumette <hchaumette@adeneo-embedded.com> a ?crit :

> 
> Update KSZ9031RN phy fixup for Congatec conga-QEVAL and conga-QMX6 combo :
> set RGMII GTX_CLK and RX_CLK pad skew to +0.96ns.
> 
> Signed-off-by: Hubert Chaumette <hchaumette@adeneo-embedded.com>
> ---
>  arch/arm/mach-imx/mach-imx6q.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.c
> index 76e5db4..db307c2 100644
> --- a/arch/arm/mach-imx/mach-imx6q.c
> +++ b/arch/arm/mach-imx/mach-imx6q.c
> @@ -77,6 +77,9 @@ static int ksz9031rn_phy_fixup(struct phy_device *dev)
>  	mmd_write_reg(dev, 2, 5, 0);
>  	mmd_write_reg(dev, 2, 8, 0x003ff);
>  
> +	/* For Congatec conga-QMX6 board */
> +	mmd_write_reg(dev, 0x02, 0x06, 0xffff);
> +
>  	return 0;
>  }
>  
that's board specific (the needed delay depends on the routing delay on
the PCB), so this should not go in a generic file.

Eric
