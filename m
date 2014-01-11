From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 11 Jan 2014 16:13:42 +0000
Subject: [PATCH REPOST] ARM: Fix regression in IXP4xx network drivers
 DMA masks.
In-Reply-To: <m3d2k4x5vo.fsf@t19.piap.pl>
References: <m338l6vldf.fsf@t19.piap.pl> <m3d2k4x5vo.fsf@t19.piap.pl>
Message-ID: <20140111161342.GM15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 06, 2014 at 08:33:15PM +0100, Krzysztof Ha?asa wrote:
> Russell et al.,
> 
> anything wrong with this fix?

Well, I don't understand why moving this code around fixes a problem.
After all, if PCI is enabled, then presumably common-pci.c will always
be built and run - it has to be for the PCI bus to be probed.

Oh, are you trying to use the platform notify callback to set the
DMA mask on statically defined platform devices?  No, don't do that,
initialise it in the declarations instead.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
