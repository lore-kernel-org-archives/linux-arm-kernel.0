From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Wed, 21 Nov 2018 22:53:57 +0100
Subject: [PATCH] clk: meson: Fix GXL HDMI PLL fractional bits width
In-Reply-To: <20181121111922.1277-1-narmstrong@baylibre.com>
References: <20181121111922.1277-1-narmstrong@baylibre.com>
Message-ID: <CAFBinCDkXYH9bCf_aaVptqcgZabreuZxLoAW3-o2qBHgcbm8Xw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Neil,

On Wed, Nov 21, 2018 at 12:19 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> The GXL Documentation specifies 12 bits for the Fractional bit field,
> bit the last bits have a different purpose that we cannot handle right
> now, so update the bitwidth to have correct fractional calculations.
I assume you have more accurate documentation than what's available publicly:
- the S805 datasheet doesn't have any documentation for this register at all
- the S905 datasheet states that HHI_HDMI_PLL_CNTL2[11:0] are DIV_FRAC
- the S905X and S912 datasheets state that SDMNC_POWER is at
HHI_HDMI_PLL_CNTL2[6:0], SDMNC_ULMS is at HHI_HDMI_PLL_CNTL2[9:7] and
SSC_DEP_SEL is at HHI_HDMI_PLL_CNTL2[13:10]
- the S905X and S912 datasheets state that HHI_HDMI_PLL_CNTL1[11:0] are DIV_FRAC

can you confirm that the public S905X and S912 documentation is wrong
and that the .frac field is really part of HHI_HDMI_PLL_CNTL2 instead
of HHI_HDMI_PLL_CNTL1?


Regards
Martin
