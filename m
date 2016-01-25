From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 25 Jan 2016 10:50:47 +0000
Subject: [PATCH v2] ARM: imx_v6_v7_defconfig: Enable GPU support
In-Reply-To: <1453682984-5785-1-git-send-email-festevam@gmail.com>
References: <1453682984-5785-1-git-send-email-festevam@gmail.com>
Message-ID: <20160125105047.GJ10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 10:49:44PM -0200, Fabio Estevam wrote:
> Select CONFIG_DRM_ETNAVIV, so that GPU support can be enabled by default.

Not yet, we know that there's the potential for oopsing the kernel by
reading a debugfs file on iMX6 platforms (due to the VG core).  Let's
get that fixed first, so it's not visible "by default".

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
