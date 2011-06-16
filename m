From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 16 Jun 2011 23:18:32 +0100
Subject: [PATCH 3.0] OMAP: drop __initdata tags from static struct
	platform_device declarations
In-Reply-To: <201106170002.46387.jkrzyszt@tis.icnet.pl>
References: <201106170002.46387.jkrzyszt@tis.icnet.pl>
Message-ID: <20110616221832.GB9698@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 17, 2011 at 12:02:46AM +0200, Janusz Krzysztofik wrote:
> Pointers to statically declared platform device structures which are 
> registered with platform_device_register() are then used during run time 
> to access these structure members, for example from platform_uevent() 
> and much more. Therefore, these structures should never be placed inside 
> sections which are dropped after boot. Fix platform devices incorrectly 
> tagged with __initdata which happen to exist inside OMAP sub-trees.

It would be a good idea to cc the authors of the patches which
introduced this stuff, so that they learn that registering platform
devices marked with __initdata is a bad idea.  We live in hope that
doing so will prevent it happening in the future.
