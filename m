From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 24 Jul 2017 14:02:38 +0800
Subject: [linux-sunxi] [PATCH v3 2/5] iio: adc: sun4i-gpadc-iio: rename
 A23/A33-specified registers to contain A23
In-Reply-To: <20170723141354.42646-3-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
 <20170723141354.42646-3-icenowy@aosc.io>
Message-ID: <CAGb2v65a3tyr5EJLgB9mhz2aYsU9NkMSg+wF_aJuhmT3tNpL2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 23, 2017 at 10:13 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> As the H3 SoC, which is also in sun8i line, has totally different
> register map for the thermal sensor (a cut down version of GPADC), we
> should rename A23/A33-specified registers to contain A23, in order to
> prevent obfuscation with H3 registers. Currently these registers are
> only prefixed "SUN8I", not "SUN8I_A23".
>
> Add "_A23" after "SUN8I" on the register names.

Nit: the compatible string as well as the initial driver targets the A33.
Naming the registers as such would be more consistent.

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
