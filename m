From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Nov 2014 16:02:05 +0000
Subject: [PATCH 1/2] ARM: imx: Remove unneeded .map_io initialization
In-Reply-To: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
References: <1415980438-12939-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20141114160205.GH4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 14, 2014 at 04:53:57PM +0100, Geert Uytterhoeven wrote:
> If machine_desc.map_io is not set, devicemaps_init() in the common ARM
> code will call debug_ll_io_init().

How about a WARN_ON(mdesc->map_io == debug_ll_io_init) ?  This can only
really be done when CONFIG_DEBUG_LL is defined because otherwise it's an
inline function, but it may help to stop these from appearing in the
first place.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
