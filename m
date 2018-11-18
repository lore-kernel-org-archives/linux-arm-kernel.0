From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 18 Nov 2018 13:48:37 +0100
Subject: [PATCH v2 2/4] clk: meson-gxbb: Fix HDMI PLL for GXL SoCs
In-Reply-To: <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
References: <1541516257-16157-1-git-send-email-narmstrong@baylibre.com>
 <1541516257-16157-3-git-send-email-narmstrong@baylibre.com>
Message-ID: <CAFBinCDQ0G-yt8a6rwpVDa6FJHr1f=VEkAX3LT95ZR+9bWAekw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Tue, Nov 6, 2018 at 3:59 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> In an attempt to better describe the HDMI PLL, a single DCO clock was
> left for GXBB and GXL, but the GXL DCO does not have a pre-multiplier.
>
> This patch adds back a GXL specific HDMI PLL DCO with xtal as parent.
according to the public S905X datasheet (from Khadas)
HHI_HDMI_PLL_CNTL2[31:30] describe the OD_FB
the 32-bit SoCs probably have an OD_FB as well and it seems that the
formula for the PLL with OD_FB is:
  in * m / n >> od << od_fb
(however, I must admit that I'm not sure where od_fb fits in best:
before the PLL DCO - like OD is after the PLL DCO, or part of the PLL
DCO)

so this is more of a question than a suggestion/feedback:
do you know whether the datasheet is correct and there's really a
programmable multiplier (called OD_FB)?
do you have more details on that topic?


Regards
Martin
