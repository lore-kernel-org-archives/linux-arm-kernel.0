From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Jan 2014 15:28:45 +0000
Subject: [PATCH v2 0/3] Fix SATA disk hotplug for Armada 370/XP SoCs
In-Reply-To: <20140114151404.GN19878@titan.lakedaemon.net>
References: <1389711007-7239-1-git-send-email-simon.guinot@sequanux.org>
 <20140114151404.GN19878@titan.lakedaemon.net>
Message-ID: <20140114152845.GI15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 14, 2014 at 10:14:04AM -0500, Jason Cooper wrote:
> Simon,
> 
> On Tue, Jan 14, 2014 at 03:50:04PM +0100, Simon Guinot wrote:
> > Hello,
> > 
> > This patch series fixes a SATA disk hotplug issue for the Armada 370/XP
> > SoCs: once a disk is removed from a SATA port, then the re-plug events
> > are not detected by the sata_mv driver.
> > 
> > This should be applied to the -stable kernels 3.10 and onwards. 
> 
> Please add a 'Fixes: <commit-hash> (oneline)' tag below the Cc: stable
> tags.  It looks like the sata_mv binding and the Armada 370 DT booting
> were both introduced in v3.6, so I would probably use:
> 
> Fixes: 9ae6f740b49f (arm: mach-mvebu: add support for Armada 370 and Armada XP with DT)

Correction - it's format is:

Fixes: <commit-hash> ("oneline")

Double-quotes inside the parens.  (Don't ask me why, that's just how it
was decided.)

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
