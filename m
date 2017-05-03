From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 May 2017 20:25:41 +0100
Subject: [PATCH] ARM: Fix rd_size declaration
In-Reply-To: <1493239894.2632.15.camel@sandisk.com>
References: <20170417231003.7178-1-bart.vanassche@sandisk.com>
 <1493239894.2632.15.camel@sandisk.com>
Message-ID: <20170503192541.GE22219@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 26, 2017 at 08:51:35PM +0000, Bart Van Assche wrote:
> On Mon, 2017-04-17 at 16:10 -0700, Bart Van Assche wrote:
> > The global variable 'rd_size' is declared as 'int' in source file
> > arch/arm/kernel/atags_parse.c and as 'unsigned long' in
> > drivers/block/brd.c. Fix this inconsistency.
> > [ ... ]
> 
> Hello Russell,
> 
> Have I sent this patch to the right maintainer?

There were comments on the patch which seemed to be unresolved.

I, too, don't like the idea of a single-line header file.  I'm also
wondering what the right solution here is - we're the only architecture
in the modern kernel that writes to rd_size, no one else does that.
I haven't been able to dig into the history to find out whether other
architectures used to, or what.

However, it would be nice if rd_size could go with some other related
declarations somewhere (if there are any.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
