From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 21 May 2017 17:27:45 +0800
Subject: [PATCH V2 2/5] pinctrl: imx: add generic pin config core support
In-Reply-To: <1495177545-23006-3-git-send-email-aisheng.dong@nxp.com>
References: <1495177545-23006-1-git-send-email-aisheng.dong@nxp.com>
 <1495177545-23006-3-git-send-email-aisheng.dong@nxp.com>
Message-ID: <20170521092743.GK26102@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 19, 2017 at 03:05:42PM +0800, Dong Aisheng wrote:
> The design is based on the exist architecture that the core will
> provide a uniformed way to decode the generic pin config into platform
> config register raw data according to the imx_cfg_params_decode maps
> registered by platform.
> 
> Two useful macros, IMX_CFG_PARAMS_DECODE and IMX_CFG_PARAMS_DECODE_INVERT,
> are created for platform to register decode map conveniently.
> 
> In order to cope with some special case, a platform specific fixup()
> function is also available to use.
> 
> Note that rather than fully utilizing the generic pinconf support
> provided by pinctrl core, IMX only adopts the device tree bindings
> of generic pinconf. The config used in .pin_config_get[set] are raw
> register data instead of generic one which makes us align the exist
> using. And that's also why we cannot set pinconf_ops.is_generic.
> 
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bai Ping <ping.bai@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
