From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 21 Nov 2012 12:40:14 +0200
Subject: [PATCH 1/1] net: add micrel KSZ8873MLL switch support
In-Reply-To: <1353493630-30867-1-git-send-email-plagnioj@jcrosoft.com>
References: <1353493630-30867-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <20121121104014.GC28785@sapphire.tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jean-Christophe,

On Wed, Nov 21, 2012 at 11:27:10AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> this will allow to detect the link between the switch and the soc
> 
> Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
> Cc: netdev at vger.kernel.org

[...]

> @@ -204,6 +237,16 @@ static struct phy_driver ksphy_driver[] = {
>  	.ack_interrupt	= kszphy_ack_interrupt,
>  	.config_intr	= ksz9021_config_intr,
>  	.driver		= { .owner = THIS_MODULE, },
> +}, {
> +	.phy_id		= PHY_ID_KSZ8873MLL,
> +	.phy_id_mask	= 0x00fffff0,
> +	.name		= "Micrel KSZ8873MLL Swithch",

s/Swithch/Switch/

> +	.features	= (SUPPORTED_Pause | SUPPORTED_Asym_Pause),
> +	.flags		= PHY_HAS_MAGICANEG,
> +	.config_init	= kszphy_config_init,
> +	.config_aneg	= ksz8873mll_config_aneg,
> +	.read_status	= ksz8873mll_read_status,
> +	.driver		= { .owner = THIS_MODULE, },
>  } };
>  
>  static int __init ksphy_init(void)

baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
