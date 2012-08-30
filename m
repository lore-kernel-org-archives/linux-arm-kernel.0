From: B29397@freescale.com (Chen Peter-B29397)
Date: Thu, 30 Aug 2012 09:40:05 +0000
Subject: MX28 & finding out boot mode
In-Reply-To: <20120830091318.GC27306@pengutronix.de>
References: <20120830082518.GA27306@pengutronix.de>
 <20120830081215.GA1198@shlinux2.ap.freescale.net>
 <F281D0F91ED19E4D8E63A7504E8A649803C63005@039-SN2MPN1-023.039d.mgd.msft.net>
 <20120830091318.GC27306@pengutronix.de>
Message-ID: <F281D0F91ED19E4D8E63A7504E8A649803C630EF@039-SN2MPN1-023.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 
> 
> Some customers want this to handle the recovery case differently than
> the standard case.
> 

If you can't find method at datasheet (like reading some registers), a workaround
is according to usb register, usually, usbcmd.rs (pull-up DP) stands for usb is using
or not.

1. Make sure usbcmd.rs = 0 is the default value.
2. Before the usb code is running, the usbcmd.rs should be 0 at normal mode
So, get a flag before usb code is running

if (usbcmd.rs == 0)
	usb_recover_mode = 0;
else
	usb_recover_mode = 1;


Peter

> Thanks for the help!
> 
>    Wolfram
> 
> --
> Pengutronix e.K.                           | Wolfram Sang
> |
> Industrial Linux Solutions                 | http://www.pengutronix.de/
> |
