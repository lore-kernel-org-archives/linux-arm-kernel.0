From: dianders@chromium.org (Doug Anderson)
Date: Fri, 9 Mar 2018 13:00:57 -0800
Subject: [PATCH v5 3/4] arm64: dts: sdm845: Add minimal dts/dtsi files for
 sdm845 SoC and MTP
In-Reply-To: <20180222061208.2031-4-rnayak@codeaurora.org>
References: <20180222061208.2031-1-rnayak@codeaurora.org>
 <20180222061208.2031-4-rnayak@codeaurora.org>
Message-ID: <CAD=FV=X6X+4J8KkKo+CNDF3a1_LP1CGzBDrVvBzXx9OdyYP+Dw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Feb 21, 2018 at 10:12 PM, Rajendra Nayak <rnayak@codeaurora.org> wrote:
> +               gcc: clock-controller at 100000 {
> +                       compatible = "qcom,gcc-sdm845";
> +                       reg = <0x100000 0x1f0000>;
> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +               };

Seems like we need "#power-domain-cells = <1>;" in the gcc node.

It is true that the property is listed as "optional" in the bindings,
but we certainly know that the
"include/dt-bindings/clock/qcom,gcc-sdm845.h" that's posted [1]
contains several defines ending in "_GDSC" and once we start
referencing those we'll need "#power-domain-cells".  Seems like we
should just have it from the beginning.

NOTE: IMHO adding "#power-domain-cells" could be done as a follow-on
patch, but since (I think) this series still hasn't landed I guess we
could just send up v6?

[1] https://patchwork.kernel.org/patch/10267093/


-Doug
