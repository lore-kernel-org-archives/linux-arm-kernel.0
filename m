From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Sep 2014 10:44:28 -0700
Subject: [PATCH] bus: omap_l3_noc: Fix connID for OMAP4
In-Reply-To: <1410344427-26006-1-git-send-email-nm@ti.com>
References: <1410344427-26006-1-git-send-email-nm@ti.com>
Message-ID: <20140911174428.GC18849@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Nishanth Menon <nm@ti.com> [140910 03:21]:
> Commit d4d8819e205854c ("bus: omap_l3_noc: fix masterid detection")
> did the right thing in dropping the LSB 2 bits which is not part
> of the ConnID for NTTP master address. However, as part of that
> change, we should also have ensured that existing list of OMAP4 connID
> codes are also shifted by 2 bits to ensure that connIDs map to "Table
> 13-18. ConnID Values" as provided in Technical Reference Manuals for
> OMAP4430(Rev AP, April 2014, SWPU220AP) and OMAP4460(Rev AB, April
> 2014, SWPU234AB)
> 
> Fixes: d4d8819e205854c ("bus: omap_l3_noc: fix masterid detection")
> Reported-by: Kristian Otnes <kotnes@cisco.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
> 
> Based on v3.17-rc1 - but might be 3.17 rc material

Yes as it's a regression. Applying into omap-for-v3.17/fixes-v3.

Tony
 
> Quick links (seems to work on firefox):
> 4430:
> http://www.ti.com/lit/ug/swpu231ap/swpu231ap.pdf#page=3030&zoom=auto,0,699.5
> 4460:
> http://www.ti.com/lit/ug/swpu235ab/swpu235ab.pdf#page=3073&zoom=auto,0,699.5
> 
> NOTE: there are a few more cleanup patches that can follow these..
> will leave those out for now.
> 
>  drivers/bus/omap_l3_noc.h |   50 ++++++++++++++++++++++-----------------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/bus/omap_l3_noc.h b/drivers/bus/omap_l3_noc.h
> index 551e010..9525458 100644
> --- a/drivers/bus/omap_l3_noc.h
> +++ b/drivers/bus/omap_l3_noc.h
> @@ -188,31 +188,31 @@ static struct l3_flagmux_data omap_l3_flagmux_clk3 = {
>  };
>  
>  static struct l3_masters_data omap_l3_masters[] = {
> -	{ 0x0 , "MPU"},
> -	{ 0x10, "CS_ADP"},
> -	{ 0x14, "xxx"},
> -	{ 0x20, "DSP"},
> -	{ 0x30, "IVAHD"},
> -	{ 0x40, "ISS"},
> -	{ 0x44, "DucatiM3"},
> -	{ 0x48, "FaceDetect"},
> -	{ 0x50, "SDMA_Rd"},
> -	{ 0x54, "SDMA_Wr"},
> -	{ 0x58, "xxx"},
> -	{ 0x5C, "xxx"},
> -	{ 0x60, "SGX"},
> -	{ 0x70, "DSS"},
> -	{ 0x80, "C2C"},
> -	{ 0x88, "xxx"},
> -	{ 0x8C, "xxx"},
> -	{ 0x90, "HSI"},
> -	{ 0xA0, "MMC1"},
> -	{ 0xA4, "MMC2"},
> -	{ 0xA8, "MMC6"},
> -	{ 0xB0, "UNIPRO1"},
> -	{ 0xC0, "USBHOSTHS"},
> -	{ 0xC4, "USBOTGHS"},
> -	{ 0xC8, "USBHOSTFS"}
> +	{ 0x00, "MPU"},
> +	{ 0x04, "CS_ADP"},
> +	{ 0x05, "xxx"},
> +	{ 0x08, "DSP"},
> +	{ 0x0C, "IVAHD"},
> +	{ 0x10, "ISS"},
> +	{ 0x11, "DucatiM3"},
> +	{ 0x12, "FaceDetect"},
> +	{ 0x14, "SDMA_Rd"},
> +	{ 0x15, "SDMA_Wr"},
> +	{ 0x16, "xxx"},
> +	{ 0x17, "xxx"},
> +	{ 0x18, "SGX"},
> +	{ 0x1C, "DSS"},
> +	{ 0x20, "C2C"},
> +	{ 0x22, "xxx"},
> +	{ 0x23, "xxx"},
> +	{ 0x24, "HSI"},
> +	{ 0x28, "MMC1"},
> +	{ 0x29, "MMC2"},
> +	{ 0x2A, "MMC6"},
> +	{ 0x2C, "UNIPRO1"},
> +	{ 0x30, "USBHOSTHS"},
> +	{ 0x31, "USBOTGHS"},
> +	{ 0x32, "USBHOSTFS"}
>  };
>  
>  static struct l3_flagmux_data *omap_l3_flagmux[] = {
> -- 
> 1.7.9.5
> 
