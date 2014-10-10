From: bjorn@kryo.se (Bjorn Andersson)
Date: Fri, 10 Oct 2014 10:14:34 -0700
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add SDHC nodes for APQ8084 platform
In-Reply-To: <1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>
 <1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
Message-ID: <CAJAp7OhV82HyDQSRW4F2z6UD6WZzuopBoUZMeT2pYBdGq-Dqcg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 2, 2014 at 8:40 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
> Enable support for the two SD host controllers on the APQ8084 platform
> by adding the required nodes to the DT files.
> On the IFC6540 board, the first controller is connected to the onboard
> eMMC and the second is connected to a micro-SD card slot.
>
> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>

Hi Georgi,

This looks sane, but...

> ---
>  arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |   11 +++++++++++
>  arch/arm/boot/dts/qcom-apq8084.dtsi        |   23 +++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
> index e41cb8a..c9ff108 100644
> --- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
> +++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
[..]
> +               sdhci at f98a4900 {
> +                       cd-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
> +                       bus-width = <4>;

...why do you add this node and leave it disabled in the dts?

> +               };
>         };
>  };

Regards,
Bjorn
