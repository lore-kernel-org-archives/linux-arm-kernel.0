From: robh+dt@kernel.org (Rob Herring)
Date: Wed, 24 May 2017 08:18:48 -0500
Subject: [PATCH v3 4/5] ARM64: dts: Add Realtek RTD1295 and Zidoo X9S
In-Reply-To: <20170514022429.11555-5-afaerber@suse.de>
References: <20170514022429.11555-1-afaerber@suse.de>
 <20170514022429.11555-5-afaerber@suse.de>
Message-ID: <CAL_JsqL5PZwKszn8Ge_VyxQE54pyD9GQUSMJp_mjtsGGVwN5xQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 13, 2017 at 9:24 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Add initial device trees for the RTD1295 SoC and the Zidoo X9S TV box.
>
> The CPUs lack the enable-method property because the vendor device tree
> uses a custom "rtk-spin-table" method and "psci" did not appear to work.
>
> The UARTs lack the interrupts properties because the vendor device tree
> connects them to a custom interrupt controller. earlycon works without.
>
> A list of memory reservations is adopted from v1.2.11 vendor device tree:
> 0x02200000 can be used for an initrd, 0x01b00000 is audio-related;
> ion-related 0x02600000, 0x02c00000 and 0x11000000 are left out;
> 0x10000000 is used for sharing the U-Boot environment; others remain
> to be investigated.
>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
>  v2 -> v3:
>  * Adopted SPDX-License-Identifier (Rob)
>  * Added ranges for /soc node (Rob)
>  * Changed #address-cells and #size-cells to 1 (Rob)
>
>  v1 -> v2:
>  * Dropped 0x0000000010000000 /memreserve/
>
>  arch/arm64/boot/dts/Makefile                      |   1 +
>  arch/arm64/boot/dts/realtek/Makefile              |   5 +
>  arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts |  42 +++++++
>  arch/arm64/boot/dts/realtek/rtd1295.dtsi          | 131 ++++++++++++++++++++++
>  4 files changed, 179 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/realtek/Makefile
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
>  create mode 100644 arch/arm64/boot/dts/realtek/rtd1295.dtsi

Reviewed-by: Rob Herring <robh@kernel.org>
