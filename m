From: dianders@chromium.org (Doug Anderson)
Date: Thu, 13 Nov 2014 09:33:15 -0800
Subject: [PATCH v11 3/3] ARM: dts: add rk3288 power-domain node
In-Reply-To: <1415829690-20236-4-git-send-email-caesar.wang@rock-chips.com>
References: <1415829690-20236-1-git-send-email-caesar.wang@rock-chips.com>
 <1415829690-20236-4-git-send-email-caesar.wang@rock-chips.com>
Message-ID: <CAD=FV=UKUnr33s85imePmcxizLK=AMYS8fPC7VvKnV4XXWFG2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Nov 12, 2014 at 2:01 PM, Caesar Wang <caesar.wang@rock-chips.com> wrote:
> +               pd_vio {
> +                       reg = <RK3288_PD_VIO>;
> +                       clocks = <&cru ACLK_IEP>,
> +                                <&cru ACLK_ISP>,
> +                                <&cru ACLK_RGA_NIU>,
> +                                <&cru ACLK_RGA>,
> +                                <&cru ACLK_VIO0_NIU>,
> +                                <&cru ACLK_VIO1_NIU>,
> +                                <&cru ACLK_VIP>,
> +                                <&cru ACLK_VOP0>,
> +                                <&cru ACLK_VOP1>,
> +                                <&cru DCLK_VOP0>,
> +                                <&cru DCLK_VOP1>,
> +                                <&cru HCLK_IEP>,
> +                                <&cru HCLK_ISP>,
> +                                <&cru HCLK_RGA>,
> +                                <&cru HCLK_VIO_AHB_ARBI>,
> +                                <&cru HCLK_VIO_NIU>,
> +                                <&cru HCLK_VIO2_H2P>,
> +                                <&cru HCLK_VIP>,
> +                                <&cru HCLK_VOP0>,
> +                                <&cru HCLK_VOP1>,
> +                                <&cru PCLK_EDP_CTRL>,
> +                                <&cru PCLK_HDMI_CTRL>,
> +                                <&cru PCLK_LVDS_PHY>,
> +                                <&cru PCLK_MIPI_CSI>,
> +                                <&cru PCLK_MIPI_DSI0>,
> +                                <&cru PCLK_MIPI_DSI1>,
> +                                <&cru PCLK_VIO2_H2P>,
> +                                <&cru SCLK_EDP_24M>,
> +                                <&cru SCLK_EDP>,
> +                                <&cru SCLK_HDMI_CEC>,
> +                                <&cru SCLK_HDMI_HDCP>,
> +                                <&cru SCLK_ISP_JPE>,
> +                                <&cru SCLK_ISP>,
> +                                <&cru SCLK_RGA>;

This was discussed offlist, but just to make sure it's summarized here:

Some of the above clocks are "IGNORE_UNUSED" (AKA left on) in Linux
right now because nobody is managing them right now (due to the fact
that they are "interface unit clocks", etc).  The fact that these are
now being enabled and disabled as part of power domain transitions
will break this.

My vote would be to leave such clocks out of the list for now until we
figure out how they should be dealt with.


-Doug
