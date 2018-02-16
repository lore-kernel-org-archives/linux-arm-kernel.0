From: dianders@chromium.org (Doug Anderson)
Date: Fri, 16 Feb 2018 11:28:03 -0800
Subject: [PATCH v4 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180216060503.22006-4-rnayak@codeaurora.org>
References: <20180216060503.22006-1-rnayak@codeaurora.org>
 <20180216060503.22006-4-rnayak@codeaurora.org>
Message-ID: <CAD=FV=WTCcMj=eGqOLY2zZCvvOZHtfX7gEiKjwm2wtUtv9U9gQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Feb 15, 2018 at 10:05 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> Add a skeletal sdm845 SoC dtsi and MTP board dts/dtsi files
>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> Reviewed-by: Doug Anderson <dianders@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/Makefile       |   1 +
>  arch/arm64/boot/dts/qcom/sdm845-mtp.dts |  15 ++
>  arch/arm64/boot/dts/qcom/sdm845.dtsi    | 277 ++++++++++++++++++++++++++++++++
>  3 files changed, 293 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845-mtp.dts
>  create mode 100644 arch/arm64/boot/dts/qcom/sdm845.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
> index 55ec5ee7f7e8..9319e74b8906 100644
> --- a/arch/arm64/boot/dts/qcom/Makefile
> +++ b/arch/arm64/boot/dts/qcom/Makefile
> @@ -6,3 +6,4 @@ dtb-$(CONFIG_ARCH_QCOM) += msm8916-mtp.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8992-bullhead-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8994-angler-rev-101.dtb
>  dtb-$(CONFIG_ARCH_QCOM)        += msm8996-mtp.dtb
> +dtb-$(CONFIG_ARCH_QCOM)        += sdm845-mtp.dtb
> diff --git a/arch/arm64/boot/dts/qcom/sdm845-mtp.dts b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> new file mode 100644
> index 000000000000..979ab49913f1
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845-mtp.dts
> @@ -0,0 +1,15 @@
> +// SPDX-License-Identifier: GPL-2.0

This already has my Reviewed-by tag (and that's great), but just
making it clear that I am in favor of this landing with just the
GPL-2.0 license and not block waiting on the QC lawyers to hash out
whether the device tree can really be dual-licensed.

If lawyers come back soon then it will be easy to have a followup
patch that changes this.  Since (I don't think) any hobbyists have an
SDM845 in their hands right now it seems unlikely to be hard to track
down any authors in the meantime and make sure they're OK.

If lawyers don't come back soon then it will be a good thing that we
didn't block.


Having this skeleton DTS file land sooner rather than later will
unblock other patches to be sent out enabling other peripherals, which
seems like a nice thing.  :)


-Doug
