From: rahul.sharma@samsung.com (Rahul Sharma)
Date: Mon, 12 May 2014 16:28:10 +0530
Subject: [PATCH v3 0/5] ARM: dts: enable hdmi for exynos5 based peach and
 snow boards
In-Reply-To: <1399890248-27409-1-git-send-email-rahul.sharma@samsung.com>
References: <1399890248-27409-1-git-send-email-rahul.sharma@samsung.com>
Message-ID: <CAPdUM4M1xR1jGPxhuUi6nnAXuzA8_-9Hbgux66g+3mobhxNwyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 May 2014 15:54, Rahul Sharma <rahul.sharma@samsung.com> wrote:
> From: Rahul Sharma <Rahul.Sharma@samsung.com>
>
> Enable hdmi for exynos5250 based snow board and exynos5420
> based peach pit board. It also adds properties to hdmi nodes
> for accessing hdmiphy as simple phys.
>
> V3:
> 1) Re-spin on dependent patches.
> 2) Added patch to enable hdmi for Peach-pi board.
>
> V2:
> 1) Re-spin on dependent patches.
> 2) Added patch to remove chip specific hdmi hpd gpio from
> board file top SoC file.
>
> This series is based on Kukjin Kims, for-next branch.
>
> It is dependent on
> 1) Arun's patch for adding peach-pit board dts file at
> http://www.spinics.net/lists/linux-samsung-soc/msg30103.html. [Patch is 'ACK'ed.]
> 2) Sachin's patch for snow board dts file at
> https://patches.linaro.org/28325/
> 3) DRM Hdmi driver patch which is changing the DT binding at
> http://www.spinics.net/lists/linux-samsung-soc/msg28052.html
> 4) Arun's patches for basic Exynos5800 support, available at
> http://comments.gmane.org/gmane.linux.kernel.samsung-soc/30667
> [Already Applied in Kukjin's v3.16-next/soc-exynos]
>

Updating the dependency:
1) Sachin's patch for snow board dts file at
       https://patches.linaro.org/28325/
2) DRM Hdmi driver patch which is changing the DT binding at
       http://www.spinics.net/lists/linux-samsung-soc/msg28052.html

All other patches are already Applied in Kukjin's for-next and
v3.16-next/soc-exynos branches.

> Rahul Sharma (5):
>   ARM: dts: enable hdmi for exynos5250 based snow board
>   ARM: dts: change to correct compatible string for exynos5420 hdmi
>   ARM: dts: enable hdmi for exynos5420 based peach-pit board
>   ARM: dts: remove chip specific hdmi hpd pin from board
>   ARM: dts: enable hdmi for exynos5800 based peach-pi board
>
>  arch/arm/boot/dts/exynos5250-cros-common.dtsi |    6 +++++-
>  arch/arm/boot/dts/exynos5250-pinctrl.dtsi     |    7 +++++++
>  arch/arm/boot/dts/exynos5250-snow.dts         |    7 +++++++
>  arch/arm/boot/dts/exynos5420-peach-pit.dts    |   19 ++++++++++++++++++
>  arch/arm/boot/dts/exynos5420-pinctrl.dtsi     |    7 +++++++
>  arch/arm/boot/dts/exynos5420-smdk5420.dts     |    9 ---------
>  arch/arm/boot/dts/exynos5420.dtsi             |    7 ++++++-
>  arch/arm/boot/dts/exynos5800-peach-pi.dts     |   26 +++++++++++++++++++++++++
>  8 files changed, 77 insertions(+), 11 deletions(-)
>
> --
> 1.7.9.5
>
