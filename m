From: dianders@chromium.org (Doug Anderson)
Date: Tue, 6 Feb 2018 13:55:14 -0800
Subject: [PATCH v2 2/3] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180131161941.29865-3-rnayak@codeaurora.org>
References: <20180131161941.29865-1-rnayak@codeaurora.org>
 <20180131161941.29865-3-rnayak@codeaurora.org>
Message-ID: <CAD=FV=W3SfQ05_jRdCOZj=sQ9POGFb5NVvpsBYRnuak8zLFBWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Jan 31, 2018 at 8:19 AM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> new file mode 100644
> index 000000000000..02520f19e4ca
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -0,0 +1,277 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +/ {
> +       model = "Qualcomm Technologies, Inc. SDM845";

I'm fairly certain that "model" doesn't belong in the SoC .dtsi file.
Only in the board .dts file.


> +       clocks {
> +               xo_board: xo_board {

Just to make it explicit: see my comments in patch 3/3 in this series
about using "_" in node names.  I believe this should be:

  xo_board: xo-board {


> +               spmi_bus: qcom,spmi at c440000 {

Drop the qcom in the node name.  AKA, I believe this should be:

spmi_bus: spmi at c440000 {

Specifically the node name is supposed to be a generic component name
then with an address.  I see that Rob Herring said the same thing when
he reviewed v1 of this patch just now (it seems like people are still
commenting there, so make sure you collect the latest feedback from
there when re-spinning).


-Doug
