From: holgerschurig@gmail.com (Holger Schurig)
Date: Mon, 2 Jun 2014 16:11:10 +0200
Subject: iMX6Q FEC: transmit queue 0 timed out
In-Reply-To: <20140602133352.GC933@n2100.arm.linux.org.uk>
References: <CAOpc7mF4naY8xuBDFNpHuQPsrULVriKj-ZcpEwpPwtA8UT1Wpw@mail.gmail.com>
 <20140602124242.GB933@n2100.arm.linux.org.uk>
 <CAOpc7mFbJQNeBmOG0C-Qn856MmhtUkTq=QeDPC-EWXryi6sFGg@mail.gmail.com>
 <20140602133352.GC933@n2100.arm.linux.org.uk>
Message-ID: <CAOpc7mHJ5CqCcB1rE3b8q58HDdSWeG41PTAMwgeARAL_hgUt_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On the Microsom, I need:
>
>       MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0xc0000000
>
> Does that work for you?

Still works in Barebox, but in Linux:

/ # ifconfig eth0 192.168.233.198
fec 2188000.ethernet eth0: MDIO write timeout
fec 2188000.ethernet eth0: MDIO read timeout
fec 2188000.ethernet eth0: MDIO write timeout
fec 2188000.ethernet eth0: could not attach to PHY
ifconfig: SIOCSIFFLAGS: Connection timed out
/ #

I see that some in-Linux-tree DTS have this value, others have
0x4001b0a8 (one in-barebox-tree DTS has a simple 0x1b0b0). Both SION
settings create the same error at ifup time for me. And Barebox
doesn't care for any of them, continue to do TFTP all the time.
