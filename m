From: mark.yao@rock-chips.com (Mark yao)
Date: Tue, 16 Feb 2016 08:44:41 +0800
Subject: [PATCH v8 0/2] Add Rockchip Inno-HDMI driver
In-Reply-To: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
References: <1454049768-30872-1-git-send-email-ykk@rock-chips.com>
Message-ID: <56C270F9.9030707@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Ping, it seems inno hdmi driver is ready, So I'd like to merge it into 
drm/rockchip if there is no doubt these days.

Thanks.
Mark
On 2016?01?29? 14:42, Yakir Yang wrote:
> Here are a brief introduction to Innosilicon HDMI IP:
>    - Support HDMI 1.4a, HDCP 1.2 and DVI 1.0 standard compliant transmitter
>    - Support HDMI1.4 a/b 3D function defined in HDMI 1.4 a/b spec
>    - Digital video interface supports a pixel size of 24, 30, 36, 48bits color depth in RGB
>    - S/PDIF output supports PCM, Dolby Digital, DTS digital audio transmission
>      (32-192kHz Fs) using IEC60958 and IEC 61937
>    - The EDID and CEC function are also supported by Innosilicon HDMI Transmitter Controlle
>
> Changes in v8:
> - Don't check whether encoder output format is RGB colorspace, cause driver
>    default configure the output colorspace to RGB. (ZhengYang)
> - Correct the check condition in inno_hdmi_config_video_csc() (ZhengYang)
>      - if (data->enc_out_format == data->enc_out_format) {
>      + if (data->enc_in_format == data->enc_out_format) {
>
> Changes in v7:
> - Correct the module licnese statement (Paul)
>       - MODULE_LICENSE("GPL");
>       + MODULE_LICENSE("GPLv2");
> - Start indentation with tabs and fix the misspell in Kconfig (Paul)
> - Carry the lost device-binding document (Heiko)
>
> Changes in v6:
> - Rebase the Makefile/Kconfig files which add by Chris's rockchip-mipi driver (Caeser)
>
> Changes in v5:
> - Use hdmi_infoframe helper functions to packed the infoframe (Russell)
> - Remove the unused double wait_for_completion_timeout for ddc transfer (Russell)
> - Remove the unused local variable in "inno_hdmi_i2c_write()" function (Russell)
>
> Changes in v4:
> - Modify the commit title "drm/rockchip: hdmi: ..." (Mark)
> - Correct the "DKMS" to "DPMS" (Mark)
> - Fix over 80 characters problems (Mark)
> - Remove encoder .prepare/.commit helper functions, and move the vop mode
> configure function into encoder .enable helper functions. (Mark)
>
> Changes in v3:
> - Use encoder enable/disable function, and remove the encoder DPMS function
> - Keep HDMI PLL power on in standby mode
>
> Changes in v2:
> - Using DRM atomic helper functions for connector init (Mark)
> - Remove "hdmi->connector.encoder = encoder;" (Mark)
> - Add the Acked-by tags from Rob
> - Correct the misspell "rk3036-dw-hdmi" (Heiko)
>
> Yakir Yang (2):
>    drm/rockchip: hdmi: add Innosilicon HDMI support
>    dt-bindings: add document for Innosilicon HDMI on Rockchip platform
>
>   .../display/rockchip/inno_hdmi-rockchip.txt        |  50 ++
>   drivers/gpu/drm/rockchip/Kconfig                   |   8 +
>   drivers/gpu/drm/rockchip/Makefile                  |   1 +
>   drivers/gpu/drm/rockchip/inno_hdmi.c               | 939 +++++++++++++++++++++
>   drivers/gpu/drm/rockchip/inno_hdmi.h               | 362 ++++++++
>   5 files changed, 1360 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/inno_hdmi-rockchip.txt
>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.c
>   create mode 100644 drivers/gpu/drm/rockchip/inno_hdmi.h
>
