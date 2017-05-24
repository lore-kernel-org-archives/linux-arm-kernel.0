From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 May 2017 08:34:08 +0200
Subject: CHIPPro NAND issue with 4.12 rc1
In-Reply-To: <a022aed57030622591a8e7eb97a59ff1@www.akkea.ca>
References: <399ea126f3b18071fbe46bfc9787df6b@www.akkea.ca>
 <20170520171418.4e8a47e0@bbrezillon>
 <6f3cefa6c54776f82160ed8954f4d0d4@www.akkea.ca>
 <20170521074535.4a4ba6dd@bbrezillon>
 <20170522070117.mwk4gm34o7idedye@flea.home>
 <63aca137397dc3700a34993205c8cfba@www.akkea.ca>
 <20170523195239.6nsv4ydrt4u7q6ge@flea.home>
 <a022aed57030622591a8e7eb97a59ff1@www.akkea.ca>
Message-ID: <20170524063408.wjo3tn6j6ymwmnns@flea.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 10:05:14PM -0600, Angus Ainslie wrote:
> On 2017-05-23 13:52, Maxime Ripard wrote:
> > 
> > Ok, good.
> > 
> > If you unrevert those patches, and add clk_ignore_unused to the kernel
> > command line, is it still broken?
> > 
> > Maxime
> 
> 
> If I use the clk_ignore_unused flag with the patches below then the kernel
> can boot and mount the nand.
> 
> diff --git a/drivers/clk/sunxi-ng/ccu-sun5i.c
> b/drivers/clk/sunxi-ng/ccu-sun5i.c
> index 5c476f9..700944c 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun5i.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun5i.c
> @@ -251,7 +251,7 @@ static SUNXI_CCU_GATE(ahb_mmc1_clk, "ahb-mmc1",
> "ahb",
>  static SUNXI_CCU_GATE(ahb_mmc2_clk,    "ahb-mmc2",     "ahb",
>                       0x060, BIT(10), 0);
>  static SUNXI_CCU_GATE(ahb_nand_clk,    "ahb-nand",     "ahb",
> -                     0x060, BIT(13), 0);
> +                     0x060, BIT(13), CLK_IS_CRITICAL);
>  static SUNXI_CCU_GATE(ahb_sdram_clk,   "ahb-sdram",    "ahb",
>                       0x060, BIT(14), CLK_IS_CRITICAL);
>  static SUNXI_CCU_GATE(ahb_emac_clk,    "ahb-emac",     "ahb",

That doesn't really make much sense, clk_ignore_unused and
CLK_IS_CRITICAL are roughly doing the same thing

Could you paste the whole kernel logs?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170524/ffdc5e3d/attachment.sig>
