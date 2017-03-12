From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Mar 2017 19:29:33 +0000
Subject: [PATCH v5 00/39] i.MX Media Driver
In-Reply-To: <191ef88d-2925-2264-6c77-46647394fc72@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <20170312175118.GP21222@n2100.armlinux.org.uk>
 <191ef88d-2925-2264-6c77-46647394fc72@gmail.com>
Message-ID: <20170312192932.GQ21222@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 12, 2017 at 12:21:45PM -0700, Steve Longerbeam wrote:
> There's actually nothing preventing userland from disabling a link
> multiple times, and imx_media_link_notify() complies, and so
> csi_s_power(OFF) gets called multiple times, and so that WARN_ON()
> in there is silly, I borrowed this from other MC driver examples,
> but it makes no sense to me, I'll remove it and prevent the power
> count from going negative.

Hmm.  So what happens if one of the CSI's links is enabled, and we
disable a different link from the CSI several times?  Doesn't that
mean the power count will go to zero despite there being an enabled
link?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
