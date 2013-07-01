From: B29397@freescale.com (Chen Peter-B29397)
Date: Mon, 1 Jul 2013 02:06:10 +0000
Subject: Chipidea usb otg support for IMX/MXS (device functionality)
In-Reply-To: <CAOMZO5AW1jcjVqEyh=qP3kQK75dZvpOY+BYcKGiymfJPLa94ew@mail.gmail.com>
References: <51A5A808.2070803@digi.com>	<201306281142.51676.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF551@039-SN2MPN1-023.039d.mgd.msft.net>
 <201306281356.51670.marex@denx.de>
 <F281D0F91ED19E4D8E63A7504E8A649803EFF788@039-SN2MPN1-023.039d.mgd.msft.net>
 <CAOMZO5AW1jcjVqEyh=qP3kQK75dZvpOY+BYcKGiymfJPLa94ew@mail.gmail.com>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803F016E2@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> >
> > You should see the voltage of vbus pin is less than 0.8v when
> > nothing is connected, we use B_SESSION_VALID (0.8v) to judge
> > it is connected or not.
> >
> > You get 2.25 all the time or it is discharged very slowly?
> 
> On my mx28evk it discharges very very slowly. Any hints about it?
> 

Due to some hardware limitations, the dual-role functions at OTG port
can't be used with host 1 port at the same time at mx28evk. Please follow
below to use USB ports at mx28evk.

When testing usb OTG port, please switch VDD 5V SOURCE SELECT to USB 5V
When testing usb host1 port, please switch VDD 5V SOURCE SELECT to WALL 5V

Best regards,
Peter
