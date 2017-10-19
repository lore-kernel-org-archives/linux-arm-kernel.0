From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 19 Oct 2017 14:48:28 +0800
Subject: [linux-sunxi] [PATCH v2 6/8] ARM: dts: sun8i: a83t: Move mmc1
 pinctrl setting to dtsi file
In-Reply-To: <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
References: <20171018083138.14517-1-wens@csie.org>
 <20171018083138.14517-7-wens@csie.org>
 <f85a30e2-5a9d-a7ba-0010-6602cabaf83e@riseup.net>
Message-ID: <CAGb2v64O+eyriHG-FirtPKo6hACfbV9JcJRUUZ+rY1QM2w_r1g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 18, 2017 at 11:00 PM, Joonas Kylm?l? <joonas.kylmala@iki.fi> wrote:
> Hi,
>
> Chen-Yu Tsai:
>> mmc1 only has 1 possible pinmux setting.
>
> What if someone is using the MMC with bus width 1 and then using the
> remaining 3 pins for something else?

I would very much like to see such a design. Currently the devices
we see all follow Allwinner's reference design, with only minor
modifications. As such, mmc1 is used exclusively for connecting
SDIO-based WiFi modules.

If such a radical(?) design is done, the vendor can always add
a "mmc1-1bit-pins" setting and override the default.

ChenYu
