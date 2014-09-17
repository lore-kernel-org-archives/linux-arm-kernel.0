From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 17 Sep 2014 10:35:34 +0800
Subject: [PATCH 2/2] ARM: imx: add anatop settings for LPDDR2 when enter
 DSM mode
In-Reply-To: <cd44d3197266427b948757c1bc4171dd@BN1PR0301MB0628.namprd03.prod.outlook.com>
References: <1410767086-3462-1-git-send-email-b20788@freescale.com>
 <1410767086-3462-2-git-send-email-b20788@freescale.com>
 <20140917022505.GE4796@dragon>
 <cd44d3197266427b948757c1bc4171dd@BN1PR0301MB0628.namprd03.prod.outlook.com>
Message-ID: <20140917023533.GF4796@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 10:31:07AM +0800, Huang Yongcai-B20788 wrote:
> > diff --git a/arch/arm/mach-imx/anatop.c b/arch/arm/mach-imx/anatop.c 
> > index 8259a62..3b25b32 100644
> > --- a/arch/arm/mach-imx/anatop.c
> > +++ b/arch/arm/mach-imx/anatop.c
> > @@ -30,11 +30,16 @@
> >  #define ANADIG_DIGPROG_IMX6SL	0x280
> >  
> >  #define BM_ANADIG_REG_2P5_ENABLE_WEAK_LINREG	0x40000
> > +#define BM_ANADIG_REG_2P5_ENABLE_PULLDOWN	0x8
> >  #define BM_ANADIG_REG_CORE_FET_ODRIVE		0x20000000
> >  #define BM_ANADIG_ANA_MISC0_STOP_MODE_CONFIG	0x1000
> > +/* Below MISC0_DISCON_HIGH_SNVS is only for i.MX6SL */
> > +#define BM_ANADIG_ANA_MISC0_DISCON_HIGH_SNVS	0x2000
> >  #define BM_ANADIG_USB_CHRG_DETECT_CHK_CHRG_B	0x80000
> >  #define BM_ANADIG_USB_CHRG_DETECT_EN_B		0x100000
> >  
> > +#define DDR_TYPE_LPDDR2		1
> 
> These two patches look good to me.  The only thing I think we may need to improve is that this DDR_TYPE_LPDDR2 should be defined in a common place, so that you do not need to define it twice, here and suspend-imx6.S.
> [Anson] The shared head file for these two files are the hardware.h, do you think it is OK to put this definition in hardware.h? Or add it in mxc.h and include it in both anatop.c and suspend-imx6.S?
> 

It's something similar to CPU type, so we can probably define it in the
same place as CPU type definition.

Shawn
