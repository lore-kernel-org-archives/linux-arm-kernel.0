From: kesavan.abhilash@gmail.com (Abhilash Kesavan)
Date: Mon, 6 Oct 2014 09:12:25 +0530
Subject: [PATCH v4 0/6] Add initial support for pinctrl on Exynos7
In-Reply-To: <1412087450-10495-1-git-send-email-a.kesavan@samsung.com>
References: <1412087450-10495-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAM4voamZhSzEANSpij6oHjEjouqCL+shxHv11Qb8ZiLG81P37g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Tue, Sep 30, 2014 at 8:00 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> Changes since v3:
>         - Changed variable name from exynos_wkup_irq_chip to irq_chip
>         - Added acked-by tag from Tomasz Figa
>
> Changes since v2:
>         - Added a .irq_chip field to the samsung_pin_bank struct
>         - Consolidated the wakeup and gpio irqd_ops
>
> Changes since v1:
>         - Marked the newly created irq_chip instances as __initdata
>         - Used kmemdup to keep a copy of the irq_chip
>         - Change the pinctrl name from sd0_rdqs to sd0_ds as per UM
>         - Moved the pinctrl enablement for exynos7 into a separate patch
>         - Added tested-by and reviewed-by tags from Thomas Abraham
>
> Following patches have been tested on linux-next (20140926).
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/
>
> Following patches are required for this series:
> 1) "tty/serial: fix config dependencies for samsung serial"
>    https://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg36208.html
> 2) "dts, kbuild: Implement support for dtb vendor subdirs" patchset
>    http://comments.gmane.org/gmane.linux.kbuild.devel/12131
> 3) "arch: arm64: enable support for Samsung Exynos7 SoC" patchset (v5)
>    http://www.spinics.net/lists/arm-kernel/msg364014.html
>
> Abhilash Kesavan (3):
>   pinctrl: exynos: Generalize the eint16_31 demux code
>   pinctrl: exynos: Consolidate irq domain callbacks
>   pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts
>
> Naveen Krishna Ch (3):
>   pinctrl: exynos: Add initial driver data for Exynos7
>   arm64: dts: Add initial pinctrl support to EXYNOS7
>   arm64: exynos: Enable pinctrl support for Exynos7
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           |    3 +
>  arch/arm64/Kconfig                                 |    2 +
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  560 ++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |   66 +++
>  drivers/pinctrl/samsung/pinctrl-exynos.c           |  196 +++++--
>  drivers/pinctrl/samsung/pinctrl-exynos.h           |    3 +
>  drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |    3 +
>  8 files changed, 799 insertions(+), 36 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi

Does this series look OK to you ?

Regards,
Abhilash
>
> --
> 1.7.9.5
>
