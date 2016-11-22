From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 22 Nov 2016 09:51:36 +0000
Subject: [RFC PATCH 03/11] ARM: omap: do not select HIGHMEM explicitly
In-Reply-To: <1479806768-39911-4-git-send-email-vladimir.murzin@arm.com>
References: <1479806768-39911-1-git-send-email-vladimir.murzin@arm.com>
 <1479806768-39911-4-git-send-email-vladimir.murzin@arm.com>
Message-ID: <20161122095136.GU1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2016 at 09:26:00AM +0000, Vladimir Murzin wrote:
> Explicit selection of HIGHMEM breaks NOMMU builds. It seems that
> HIGHMEM is user selectable option, so probably it would be better to
> let user to make a decision on this options or, at least, move it to
> defconfig.

That's kind of the point of ARCH_OMAP2PLUS_TYPICAL - it's a user
option to let the user select a range of options for typical OMAP2+
configurations, so that the user doesn't have to dig around looking
for multiple options, some of which are hard requirements for OMAP
to be functional.  OMAP is a particularly difficult case because the
hardware tends to be very complex.

However, HIGHMEM should never be a requirement to boot, so this looks
sane.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
