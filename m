From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 22 May 2012 12:32:34 +0800
Subject: [PATCH v2 09/12] ARM: imx6q: disable usb charger detector
In-Reply-To: <20120522034809.GI8140@S2101-09.ap.freescale.net>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-10-git-send-email-richard.zhao@freescale.com>
 <20120522034809.GI8140@S2101-09.ap.freescale.net>
Message-ID: <20120522043233.GJ6206@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 22, 2012 at 11:48:11AM +0800, Shawn Guo wrote:
> On Mon, May 21, 2012 at 05:23:54PM +0800, Richard Zhao wrote:
> > +static void __init imx6q_usb_init(void)
> > +{
> > +#define HW_ANADIG_USB1_CHRG_DETECT		0x000001b0
> > +#define HW_ANADIG_USB2_CHRG_DETECT		0x00000210
> > +
> > +#define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x00100000
> > +#define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x00080000
> > +
> > +	/*
> > +	 * The external charger detector needs to be disabled,
> > +	 * or the signal at DP will be poor
> > +	 */
> > +
> Nit: drop this unnecessary new line.
OK. 

Thanks
Richard
> 
> Regards,
> Shawn
> 
> > +	anatop_write_reg(NULL, HW_ANADIG_USB1_CHRG_DETECT,
> > +			BM_ANADIG_USB_CHRG_DETECT_EN_B
> > +			| BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
> > +			~0);
> > +	anatop_write_reg(NULL, HW_ANADIG_USB2_CHRG_DETECT,
> > +			BM_ANADIG_USB_CHRG_DETECT_EN_B |
> > +			BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B,
> > +			~0);
> > +}
> > +
> 
