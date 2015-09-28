From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Mon, 28 Sep 2015 23:08:17 +0300
Subject: [PATCH] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter support
In-Reply-To: <1443470762-17937-1-git-send-email-vladimir_zapolskiy@mentor.com>
References: <1443470762-17937-1-git-send-email-vladimir_zapolskiy@mentor.com>
Message-ID: <56099E31.6050908@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28.09.2015 23:06, Vladimir Zapolskiy wrote:
> The change adds support of internal HDMI I2C master controller, this
> subdevice is used by default, if "ddc-i2c-bus" DT property is omitted.
> 
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
>  .../devicetree/bindings/drm/bridge/dw_hdmi.txt     |   4 +-
>  drivers/gpu/drm/bridge/dw_hdmi.c                   | 263 ++++++++++++++++++++-
>  drivers/gpu/drm/bridge/dw_hdmi.h                   |  19 ++
>  3 files changed, 279 insertions(+), 7 deletions(-)
> 

This change is the same as one in reply, but no changelog/version info
(sent by mistake two copies, sorry for confusion).

--
With best wishes,
Vladimir
