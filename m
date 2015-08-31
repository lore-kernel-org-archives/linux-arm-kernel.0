From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 31 Aug 2015 11:22:43 +0200
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <1441012963.3234.28.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

Am Montag, den 31.08.2015, 00:34 +0300 schrieb Vladimir Zapolskiy:
> The change adds support of internal HDMI I2C master controller, this
> subdevice is used by default, if "ddc-i2c-bus" DT property is omitted.

I think this should be mentioned in
Documentation/devicetree/bindings/drm/bridge/dw_hdmi.txt

> The main purpose of this functionality is to support reading EDID from
> an HDMI monitor on boards, which don't have an I2C bus connected to
> DDC pins.
> 
> The current implementation does not support "I2C Master Interface
> Extended Read Mode" to read data addressed by non-zero segment
> pointer, this means that if EDID has more than 1 extension blocks,
> EDID reading operation won't succeed, in my practice all tested HDMI
> monitors have at maximum one extension block.
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
> ---
> The change is based on today's v4.2, please let me know, if it should be rebased.
> 
> The change has compilation dependency on I2CM_ADDRESS register name fix,
> see http://lists.freedesktop.org/archives/dri-devel/2015-May/082980.html
> 
> From http://lists.freedesktop.org/archives/dri-devel/2015-May/082981.html
> v1 of the change was
> 
>   Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> but I hesitate to add the tag here due to multiple updates in v2.

Tested again, v2 still works fine on Nitrogen6X with HDMI monitor.

regards
Philipp
