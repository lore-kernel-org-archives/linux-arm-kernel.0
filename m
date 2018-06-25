From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Mon, 25 Jun 2018 19:25:59 +0200
Subject: [RfC v1 4/5] ARM64: dts: meson-gxl: add support for the S905W SoC
 and the P281 board - WiP
In-Reply-To: <fb3bfe0c-2cfc-5e92-5271-e2159f20b019@baylibre.com>
References: <20180624182814.31691-1-martin.blumenstingl@googlemail.com>
 <20180624182814.31691-5-martin.blumenstingl@googlemail.com>
 <fb3bfe0c-2cfc-5e92-5271-e2159f20b019@baylibre.com>
Message-ID: <CAFBinCChoyoqc7f09JDLg7xJ3bGu3bJrCk88ekHO2Yfmr6AZow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Mon, Jun 25, 2018 at 2:51 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> Hi Martin, Kevin, Carlo, Jerome,
>
> I would like to discuss how we should handle all the GXl variants, since from linux PoV, S905x, S905W and S805X are the same (S905W and S805X only has ledd IO balls, less IO available but same pinctrl interface).
>
> At some point, meson-gxl-s905w.dtsi and meson-gxl-s805x.dtsi will be exactly the same as meson-gxl-s905x.dtsi, and maybe the same for S905Z in the Fire TV.
like you mentioned, most things (all using the internal PHY, same GPU,
same pinctrl interface, ...) are going to be identical, but what about
the differences?
- available HDMI modes are different for S905X (max. 4k60), S905W
(max. 4k30) and S805X (max. 1080p)
- video encoders / decoders are different for S905X (max. 4k60), S905W
(max. 4k30) and S805X (max. 1080p)
- CPU frequency changes are probably a no-op for us since it's handled
by the SCPI firmware: 1.5GHz for S905X, 1.2GHz for S905W and S805X
- according to lvrp16 the S805X SoC itself measures 11mm x 11mm
whereas the S905X SoC measures 14mm x 14mm
- what else did I miss?

at least the first two may require SoC/package specific compatible
strings for the HDMI controller and video decoder (if these IP blocks
don't come with a way to auto-detect the max supported resolutions)


Regards
Martin
