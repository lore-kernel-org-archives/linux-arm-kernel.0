From: fugang.duan@freescale.com (Duan Andy)
Date: Thu, 20 Aug 2015 01:16:40 +0000
Subject: [PATCH v1 1/6] net: phy: broadcom: add bcm54220 phy ID
In-Reply-To: <CAGVrzcak2u_kBg1o061OO0UK8sdrXaKF+-7eREwByD-dQ1r1XQ@mail.gmail.com>
References: <1439962444-27486-1-git-send-email-b38611@freescale.com>
 <1439962444-27486-2-git-send-email-b38611@freescale.com>
 <CAGVrzcak2u_kBg1o061OO0UK8sdrXaKF+-7eREwByD-dQ1r1XQ@mail.gmail.com>
Message-ID: <BN3PR0301MB12198F2E8A1D508EE4FB0419F5660@BN3PR0301MB1219.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Florian Fainelli <f.fainelli@gmail.com> Sent: Thursday, August 20, 2015 5:29 AM
> To: Duan Fugang-B38611
> Cc: shawnguo at kernel.org; David Miller; netdev; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH v1 1/6] net: phy: broadcom: add bcm54220 phy ID
> 
> 2015-08-18 22:33 GMT-07:00 Fugang Duan <b38611@freescale.com>:
> > Add bcm54220 phy ID entry.
> 
> This change itself is fine, but looking at the rest of your changes, we
> are not adding an entry for this PHY in drivers/net/phy/broadcom.c, which
> means that we will bind to the Generic PHY driver, and so this looks
> sufficient, even with your fixup done in the subsequent patch.
> 

Thanks for your comment.

Yes, for the phy, the driver use generic phy driver. 
I see all Broadcom phy ID are defined in this file, we shouldn't define new phy id in other place.
When the phy is used more popular, I think the patch is very reasonable.

> >
> > Signed-off-by: Fugang Duan <B38611@freescale.com>
> > ---
> >  include/linux/brcmphy.h | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h index
> > 697ca77..20bed15 100644
> > --- a/include/linux/brcmphy.h
> > +++ b/include/linux/brcmphy.h
> > @@ -16,6 +16,7 @@
> >  #define PHY_ID_BCM5482                 0x0143bcb0
> >  #define PHY_ID_BCM5411                 0x00206070
> >  #define PHY_ID_BCM5421                 0x002060e0
> > +#define PHY_ID_BCM54220                        0x600d8589
> >  #define PHY_ID_BCM5464                 0x002060b0
> >  #define PHY_ID_BCM5461                 0x002060c0
> >  #define PHY_ID_BCM54616S               0x03625d10
> > --
> > 1.9.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel at lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
> 
> 
> --
> Florian
