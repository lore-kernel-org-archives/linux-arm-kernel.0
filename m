From: fugang.duan@freescale.com (fugang.duan at freescale.com)
Date: Tue, 3 Jun 2014 03:22:45 +0000
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
 <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
Message-ID: <d7f1957c2afc44e8b900001e606905c0@BLUPR03MB373.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Holger Schurig <holgerschurig@gmail.com> Data: Monday, June 02, 2014 10:11 PM
> To: Russell King - ARM Linux
> Cc: linux-arm-kernel at lists.infradead.org
> Subject: Re: iMX6Q FEC: transmit queue 0 timed out
> 
> > On the Microsom, I need:
> >
> >       MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0xc0000000
> >
> > Does that work for you?
> 
> Still works in Barebox, but in Linux:
> 
> / # ifconfig eth0 192.168.233.198
> fec 2188000.ethernet eth0: MDIO write timeout fec 2188000.ethernet eth0:
> MDIO read timeout fec 2188000.ethernet eth0: MDIO write timeout fec
> 2188000.ethernet eth0: could not attach to PHY
> ifconfig: SIOCSIFFLAGS: Connection timed out / #
> 
> I see that some in-Linux-tree DTS have this value, others have
> 0x4001b0a8 (one in-barebox-tree DTS has a simple 0x1b0b0). Both SION
> settings create the same error at ifup time for me. And Barebox doesn't
> care for any of them, continue to do TFTP all the time.

You can use the setting "0x4001b0a8" that SION bit set. And please make sure GPR1[21] is set ?
For imx6q/dl silicon, enet RMII mode, ANATOP/CCM supply 50Mhz clock for enet reference clock and phy like:
ANATOP enet PLL --> GPIO_16 PAD  --> output 50Mhz to phy
				|
				|
			 Loopback to enet RMII reference clock

1. GPIO_16 SION bit must be set.
2. GPR1[21] must be set.

Thanks,
Andy
