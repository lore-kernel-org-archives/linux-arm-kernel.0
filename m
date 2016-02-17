From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 17 Feb 2016 20:08:28 +0000
Subject: [PATCH v5 RESEND 4/5] ARM: amba: Move reading of periphid to
 amba_match()
In-Reply-To: <56C426C4.7040907@samsung.com>
References: <1455101250-11327-1-git-send-email-m.szyprowski@samsung.com>
 <1455101250-11327-5-git-send-email-m.szyprowski@samsung.com>
 <20160215175250.GJ10826@n2100.arm.linux.org.uk>
 <56C426C4.7040907@samsung.com>
Message-ID: <20160217200828.GH19428@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 17, 2016 at 08:52:36AM +0100, Marek Szyprowski wrote:
> Then the only solution right now I see is to get back to v1:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-November/388199.html
> which at least handles correctly device registration when power domain
> driver is available.

... and which has the ability to break platforms if the PM domain is
not already available.

What's wrong with the patch in the link above _combined_ with a patch
which addresses the concern I have with that patch: build a list of
the failed-to-register devices, and retry them later - maybe from a
late_initcall(), or a similar mechanism?

My view is the risk to existing systems is _too_ high to apply either
this patch, or the patch you link to above, and I refuse to play the
"lets apply it and see if we break anything" lottery with this.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
