From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 26 Jun 2017 10:38:41 +0100
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <1498076766.26050.1.camel@wdc.com>
References: <20170503194600.16089-1-bart.vanassche@sandisk.com>
 <1498076766.26050.1.camel@wdc.com>
Message-ID: <20170626093841.GF4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 08:26:07PM +0000, Bart Van Assche wrote:
> On Wed, 2017-05-03 at 12:46 -0700, Bart Van Assche wrote:
> > The global variable 'rd_size' is declared as 'int' in source file
> > arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> > drivers/block/brd.c. Fix this inconsistency. Additionally, remove
> > the declarations of rd_image_start, rd_prompt and rd_doload from
> > parse_tag_ramdisk() since these duplicate existing declarations
> > in <linux/initrd.h>.
> 
> (replying to my own e-mail)
> 
> Hello Russell,
> 
> Did I send this patch to the right maintainer? If so, do you want to share
> any feedback about this patch?

Acked-by: Russell King <rmk+kernel@armlinux.org.uk>

I think it's fine from an ARM point of view.  It seems most of this patch
is to do with initrds, so I guess if no one else is interested in it,
akpm may pick it up.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
