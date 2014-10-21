From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Oct 2014 11:02:10 +0200
Subject: [PATCH v2 4/4] ARM: dts: mt8135: Add pinctrl node for mt8135.
In-Reply-To: <20141006071841.GN4992@pengutronix.de>
References: <1411443545-24951-1-git-send-email-srv_hongzhou.yang@mediatek.com>
 <1411443545-24951-5-git-send-email-srv_hongzhou.yang@mediatek.com>
 <CACRpkda-K7w-bY0uSdnZvzEKEeQg38oExoHPSW61kEv9Wv20mA@mail.gmail.com>
 <20140924124044.GC4992@pengutronix.de>
 <CACRpkdbtN-BDEwpJO2swnOjCe3UJhD5WOXXKBV0hPOe2M2=k7Q@mail.gmail.com>
 <20141006071841.GN4992@pengutronix.de>
Message-ID: <CACRpkdbEmo1GePLnE4YvtaeBLKqhn_WsmdQKnArFthKCVPNKvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 6, 2014 at 9:18 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Oct 02, 2014 at 04:02:58PM +0200, Linus Walleij wrote:

>> What is the alternative? Device Tree is very much about strings,
>> as is shown by the pin config bindings.
>
> The alternative is to use numbers. The majority of SoCs have a bit field
> per pad which is used for muxing the pad to different functions. The
> natural way to describe this is a pair of numbers: <pad-number>
> <function-number>.  The pad number can normally be directly translated
> into a register offset and the function number to a value written to
> that register. This is true for most SoCs I know of and makes it very
> easy to generate code for and to prove for correctness of both the code
> and the device tree.

To me this sounds more like a discussion on how to set up a good
firmware (BIOS) that the kernel can call into.

We have had many times the discussion whether DT should contain
"jam tables" and such things, i.e. stuff that basically translate
DT directly to register writes.

The one exception we have for this is pinctrl-single.c which uses a
single word to configure a pin. I'm even not sure that was a good
idea but it was a compromise.

If someone wants the above, they should use pinctrl-single.c
(OMAP and HiSilicon uses it already), if they need another necessarily
different driver I'm very reluctant.

Yours,
Linus Walleij
