From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Fri, 19 May 2017 18:15:26 +0100
Subject: [CFT] Always enable SMP mode on MP capable CPUs
In-Reply-To: <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
References: <20170518105209.GN22219@n2100.armlinux.org.uk>
 <CAOMZO5Da2R2_t2nU+MdrJiSzvcBQKS4pwYS96r4UyfGc8DtWww@mail.gmail.com>
 <CAOMZO5Dc=i7UdQH=r5RRr_4GmyZZT+rh7BTNV4WbfqKvtVDfsw@mail.gmail.com>
Message-ID: <20170519171526.GW22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 02:07:28PM -0300, Fabio Estevam wrote:
> On Thu, May 18, 2017 at 3:09 PM, Fabio Estevam <festevam@gmail.com> wrote:
> 
> > I tested this patch on a mx6ul, which is CortexA7 UP using USB serial
> > download mode.
> >
> > In this boot mode the ROM code does not set the SMP bit and I can
> > notice a very slow boot progress with CONFIG_SMP=n with an original
> > 4.12-rc1.
> >
> > With this patch applied it boots with the correct speed, so:
> 
> However the kernel still takes a long time to decompress when the
> bootloader or ROM does not set the SMP bit.
> 
> After it decompress, then it boots quickly.
> 
> Should the SMP bit be set inside arch/arm/boot/compressed/head.S?

We could expand the table to positively identify the SMP capable CPUs
and enable the SMP bit there, but it's going to add a lot of entries
there (one for each specific ARMv7 MP CPU) and is going to have to be
endlessly added to each time a new SMP CPU comes out.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
