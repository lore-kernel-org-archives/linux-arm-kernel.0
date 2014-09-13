From: ta.omasab@gmail.com (Thomas Abraham)
Date: Sat, 13 Sep 2014 16:38:22 +0530
Subject: [PATCH 0/4] Add initial support for pinctrl on Exynos7
In-Reply-To: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
References: <1410598252-30931-1-git-send-email-a.kesavan@samsung.com>
Message-ID: <CAJuA9ah-krSiN5=r82rPnoNBtU2rCDXkRUDQhre5kekOvC-N_A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 13, 2014 at 2:20 PM, Abhilash Kesavan <a.kesavan@samsung.com> wrote:
> The following patches are tested based on Kgene's for-next tree.
> https://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git/log/?h=for-next
>
> Following patches are required for this series:
> 1- "tty/serial: fix config dependencies for samsung serial"
>    https://www.mail-archive.com/linux-samsung-soc <at> vger.kernel.org/msg36208.html
> 2- "dts, kbuild: Implement support for dtb vendor subdirs" patchset
>    http://comments.gmane.org/gmane.linux.kbuild.devel/12131
> 3- "arch: arm64: enable support for Samsung Exynos7 SoC" patchset
>    http://www.spinics.net/lists/linux-samsung-soc/msg36728.html
>
> Abhilash Kesavan (2):
>   pinctrl: exynos: Generalize the eint16_31 demux code
>   pinctrl: exynos: Add irq_chip instance for Exynos7 wakeup interrupts
>
> Naveen Krishna Chatradhi (2):
>   pinctrl: exynos: Add initial driver data for Exynos7
>   arm64: dts: Add initial pinctrl support to EXYNOS7
>
>  .../bindings/pinctrl/samsung-pinctrl.txt           |    3 +
>  arch/arm64/Kconfig                                 |    2 +
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  560 ++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |   66 +++
>  drivers/pinctrl/samsung/pinctrl-exynos.c           |  161 +++++-
>  drivers/pinctrl/samsung/pinctrl-exynos.h           |    4 +
>  drivers/pinctrl/samsung/pinctrl-samsung.c          |    2 +
>  drivers/pinctrl/samsung/pinctrl-samsung.h          |    1 +
>  8 files changed, 788 insertions(+), 11 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi

Tested GPIO and Wakeup interrupts. After fixing comments for patches
in this series, this series

Reviewed-by: Thomas Abraham <thomas.ab@samsung.com>
Tested-by: Thomas Abraham <thomas.ab@samsung.com>

>
> --
> 1.7.9.5
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
