From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 28 Aug 2016 18:15:31 +0200
Subject: [PATCH v2 1/4] net: dt-bindings: Document the new Meson8b and
 GXBB DWMAC bindings
In-Reply-To: <4041259.IszN4229Cj@wuerfel>
References: <20160815164100.27766-1-martin.blumenstingl@googlemail.com>
 <7308700.atIMKyMFZU@wuerfel>
 <CAFBinCA0HWHR3UbVX-_wU14W0-KOr-BAf5Nyn1ocZdnYxojn2Q@mail.gmail.com>
 <4041259.IszN4229Cj@wuerfel>
Message-ID: <CAFBinCDnHGf=wgvm9KzYQsf=kCrOUeO3bnEwdGy_OK-wgWkDug@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 5:25 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> It really depends on the kind of SoC. Some may have a suboptimal
> binding, on some others there may be a distinct register area that
> just contains a few additional registers for the dwmac.
the dwmac PHY configuration registers (2x32bit) on the GXBB SoC are
part of the "periphs" region/module. This is already defined as
"simple-bus" in meson-gxbb.dtsi, see [0]
On Meson8b this is slightly different: there is no specific "periphs"
region - there the dwmac PHY configuration registers are directly
located in the cbus region at a slightly different offset than on the
GXBB SoCs.

In the future we might need a third memory region because the latest
reference kernel contains some more PHY configuration registers on
newer SoCs (GXL = S905X).

Please let me know if you're OK with the dts definition in it's
current state - or let me know how you would like to change it.

PS: I will re-send the patches in a v3 in a few minutes because that
fixes a bug during module unload.


Regards,
Martin


[0] https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi#n217
