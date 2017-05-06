From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 6 May 2017 19:29:22 +0200
Subject: [PATCH 0/2] Amlogic Meson (32-bit) .dts cleanups
In-Reply-To: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
References: <20170417213938.22626-1-martin.blumenstingl@googlemail.com>
Message-ID: <CAFBinCDSv7GZh8bkAO_NuLibVAiwjSBXzwGFTmTixro-MNg+wQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Carlo,

On Mon, Apr 17, 2017 at 11:39 PM, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
> This series provides a few cleanups in the 32-bit Amlogic .dts files.
>
> The first patch introduces the actual busses so the .dts' basic structure
> is similar to what we have in the 64-bit .dts files.
>
> The second patch removes even more duplication by inheriting meson.dtsi
> from meson8b.dtsi (just like meson6.dtsi and meson8.dtsi are doing).
>
> There should not be any functional changes with these patches. However,
> I was only test this on a Meson8 based device, so it would be great if
> somebody could test this on a Meson8b device.
>
>
> Martin Blumenstingl (2):
>   ARM: dts: meson: organize devices in their corresponding busses
>   ARM: dts: meson8b: inherit meson.dtsi from meson8b.dtsi
>
>  arch/arm/boot/dts/meson.dtsi   | 180 ++++++++++++++++++-----------------
>  arch/arm/boot/dts/meson6.dtsi  |   2 -
>  arch/arm/boot/dts/meson8.dtsi  | 116 +++++++++++++++--------
>  arch/arm/boot/dts/meson8b.dtsi | 210 +++++++++++++++++------------------------
>  4 files changed, 255 insertions(+), 253 deletions(-)
>
> --
> 2.12.2
>
unfortunately I don't have a Meson8b device where I could test this.
can we let kernelci test this on the Odroid-C1? Meson8b can currently
only boot ramdisks (no MMC, no USB, etc.) - so I think kernelci would
catch all regressions (if there are any)
