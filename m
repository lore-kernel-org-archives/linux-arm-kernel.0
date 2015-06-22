From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Jun 2015 11:10:38 +0100
Subject: [PATCH v5 4/6] drm: bridge/dw_hdmi-i2s-audio: add audio driver
In-Reply-To: <1434967564.31094.20.camel@x220>
References: <1434730417-10629-1-git-send-email-ykk@rock-chips.com>
 <1434731295-11060-1-git-send-email-ykk@rock-chips.com>
 <1434967564.31094.20.camel@x220>
Message-ID: <20150622101038.GV7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 22, 2015 at 12:06:04PM +0200, Paul Bolle wrote:
> But I think there's no platform_device with a "dw-hdmi-i2s-audio" name.
> So I wonder whether this MODULE_ALIAS() is actually needed. What breaks
> if you leave it out?

+       } else if (hdmi_readb(hdmi, HDMI_CONFIG0_ID) & HDMI_CONFIG0_I2S) {
+               pdevinfo.name = "dw-hdmi-ahb-audio";

This should be "dw-hdmi-i2s-audio" to avoid picking up on my AHB audio
driver.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
