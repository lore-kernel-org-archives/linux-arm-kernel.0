From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 10:35:50 +0000
Subject: Booting CNS3420 EVB v 1.3 failed with 2.6.36 (and 2.6.35)
In-Reply-To: <20101109101433.GA17423@oksana.dev.rtsoft.ru>
References: <AANLkTik-4p=rBVO9GVoa8L2pEVQtaPkyYmWebuZwAshG@mail.gmail.com>
	<20101105074418.GA5864@oksana.dev.rtsoft.ru>
	<AANLkTimH0JVcB31usN5srPNYCR8sR75J23FtTPQK1Chf@mail.gmail.com>
	<20101109101433.GA17423@oksana.dev.rtsoft.ru>
Message-ID: <20101109103550.GB2869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 01:14:33PM +0300, Anton Vorontsov wrote:
> On Tue, Nov 09, 2010 at 03:12:25PM +0800, Lin Mac wrote:
> > > setenv bootargs console=ttyS0,38400 ip=on
> > Changing this doesn't take effect. I was trying console=ttyS0,115200
> > and root=/dev/ram0, but it just boot with the configured parameter
> > instead of the given one.
> > 
> > Is it also the issue of u-boot?
> 
> Nope. Just remove CONFIG_CMDLINE from your kernel .config file. ;-)

No.  The external command line overrides the built-in one unless
CMDLINE_FORCE is set.
