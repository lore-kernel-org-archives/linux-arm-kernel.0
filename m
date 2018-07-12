From: dianders@chromium.org (Doug Anderson)
Date: Thu, 12 Jul 2018 10:14:32 -0700
Subject: [PATCH v7 3/7] arm64: dts: msm8996: thermal: Initialise via DT
 and add second controller
In-Reply-To: <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
References: <cover.1531384019.git.amit.kucheria@linaro.org>
 <f6cb99e6b805b0850b039e4f5d469e761d84f6d0.1531384019.git.amit.kucheria@linaro.org>
Message-ID: <CAD=FV=W-7CfChV0wn29uR-OH7mH65kmO=0yQUWUbksmb6qL=GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 12, 2018 at 1:39 AM, Amit Kucheria <amit.kucheria@linaro.org> wrote:
> We also split up the regmap address space into two, for the TM and SROT
> registers. This was required to deal with different address offsets for the
> TM and SROT registers across different SoC families.
>
> 8996 has two TSENS IP blocks, initialise the second one too.
>
> Since tsens-common.c/init_common() currently only registers one address
> space, the order is important (TM before SROT). This is OK since the code
> doesn't really use the SROT functionality yet.
>
> Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> Tested-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>  arch/arm64/boot/dts/qcom/msm8996.dtsi | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
