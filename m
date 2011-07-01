From: tony@atomide.com (Tony Lindgren)
Date: Fri, 1 Jul 2011 00:12:27 -0700
Subject: [RESEND] [PATCH 3.0] OMAP: drop __initdata tags from static
	struct platform_device declarations
In-Reply-To: <201106170318.32326.jkrzyszt@tis.icnet.pl>
References: <201106170002.46387.jkrzyszt@tis.icnet.pl>
	<20110616221832.GB9698@n2100.arm.linux.org.uk>
	<201106170318.32326.jkrzyszt@tis.icnet.pl>
Message-ID: <20110701071227.GA23145@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> [110616 18:15]:
> Pointers to statically declared platform device structures which are 
> registered with platform_device_register() are then used during run time 
> to access these structure members, for example from platform_uevent() 
> and much more. Therefore, these structures should never be placed inside 
> sections which are dropped after boot. Fix platform devices incorrectly 
> tagged with __initdata which happen to exist inside OMAP sub-trees.
> 
> This bug has exhibited itself on my ARM/OMAP1 based Amstrad Delta 
> videophone after commit 6d3163ce86dd386b4f7bda80241d7fea2bc0bb1d, "mm: 
> check if any page in a pageblock is reserved before marking it 
> MIGRATE_RESERVE", resulting in reading from several 
> /sys/device/platform/*/uevent files always ending up with segmentation 
> faults.

Thanks applying into devel-fixes.

Tony
