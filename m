From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 18 Jun 2010 00:00:08 +0100
Subject: [PATCH 08/10] arm: deprecate support for old way to pass
	kernel parameters
In-Reply-To: <AANLkTikNtX5TiPlWOAf_C-HqK7kchZgwi-MQzQqgtush@mail.gmail.com>
References: <20100610102427.GC31057@pengutronix.de>
	<1276165636-20150-8-git-send-email-u.kleine-koenig@pengutronix.de>
	<AANLkTikNtX5TiPlWOAf_C-HqK7kchZgwi-MQzQqgtush@mail.gmail.com>
Message-ID: <20100617230008.GA10780@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 17, 2010 at 05:58:42PM +0800, Eric Miao wrote:
> 2010/6/10 Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>:
> > This was deprecated in 2001 and announced to live on for 5 years.
> >
> > For now provide a kernel parameter for those who still need it.
> >
> > Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> 
> Looks OK to me, Acked.
> 
> BTW, is there any existing usage of this and can we remove this
> completely from now on?

Boot messages from my firewall:

Linux version 2.6.32.8 (rmk at rmk-PC) (gcc version 3.4.3) #11 Sat Mar 27 20:51:49 GMT 2010
CPU: StrongARM-110 [4401a102] revision 2 (ARMv4), cr=0000517d
CPU: VIVT data cache, VIVT instruction cache
Machine: EBSA110
Converting old-style param struct to taglist
ATAG_INITRD is deprecated; please update your bootloader.
Memory policy: ECC disabled, Data cache writeback

Obviously, being a critical machine here, and that I have no way to jtag
it if I brick it, I'm not going to replace the boot loader (which
incidentally can only bootp/tftp one file - the one in the bootp packet.)
