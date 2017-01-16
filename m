From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Mon, 16 Jan 2017 15:24:59 +0100
Subject: [GIT PULL] Amlogic fixes for v4.10-rc4
In-Reply-To: <m2inpi6d09.fsf@baylibre.com>
References: <m2inpi6d09.fsf@baylibre.com>
Message-ID: <c781a080-455f-bba2-1bfb-cdd39343842b@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 13.01.2017 um 19:17 schrieb Kevin Hilman:
> ----------------------------------------------------------------
> Amlogic fixes for v4.10-rc4
> - odroid-c2: disable DVFS to avoid crashes due to broken SCPI
> - fix misc. crashes by adding known reserved memory regions
> 
> ----------------------------------------------------------------
> Neil Armstrong (2):
>       ARM64: dts: meson-gxbb-odroidc2: Disable SCPI DVFS

>       ARM64: dts: meson-gx: Add reserved memory zone and usable memory range

Objection against the latter patch introducing widespread usage of
hardcoded linux,usable-memory properties - please review closely before
considering to merge.

Thanks,
Andreas

> 
>  arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi       |  5 -----
>  arch/arm64/boot/dts/amlogic/meson-gx.dtsi                 | 12 ++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts       | 10 +++++++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts           |  9 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p201.dts           |  9 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi          |  5 -----
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-meta.dts  |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-pro.dts   |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95-telos.dts |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi               |  2 +-
>  arch/arm64/boot/dts/amlogic/meson-gxl-nexbox-a95x.dts     |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts      |  9 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p231.dts      |  9 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxl-s905x-p212.dts      |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts       |  6 +++++-
>  arch/arm64/boot/dts/amlogic/meson-gxm-s912-q200.dts       |  9 +++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxm-s912-q201.dts       |  9 +++++++++
>  18 files changed, 111 insertions(+), 19 deletions(-)
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic
> 


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
