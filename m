From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 9 Apr 2012 22:27:48 +0100
Subject: [PATCH V3 1/5] ARM: kirkwood: Basic support for DNS-320 and
 DNS-325
In-Reply-To: <20120406234955.840F73E1323@localhost>
References: <1332885255-8304-1-git-send-email-jm@lentin.co.uk>
 <1332885255-8304-2-git-send-email-jm@lentin.co.uk>
 <20120406234955.840F73E1323@localhost>
Message-ID: <20120409212748.GJ24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 06, 2012 at 04:49:55PM -0700, Grant Likely wrote:
> On Tue, 27 Mar 2012 22:54:11 +0100, Jamie Lentin <jm@lentin.co.uk> wrote:
> > +config MACH_DNS320_DT
> > +	bool "D-Link DNS-320 (Flattened Device Tree)"
> > +	select ARCH_KIRKWOOD_DT
> > +	select MACH_DNSKW_DT
> > +	select CONFIG_MTD_OF_PARTS
> > +	select CONFIG_SERIAL_OF_PLATFORM
> 
> These two lines are dangerous.

No they aren't - at least not as the above patch is written.  There are
no configuration variables called CONFIG_CONFIG_MTD_OF_PARTS nor
CONFIG_CONFIG_SERIAL_OF_PLATFORM.

Kconfig won't warn about that, and if we assume that this patch has been
properly tested, it would appear that these two select statements just
aren't required (because they're effective no-ops as they currently stand).
