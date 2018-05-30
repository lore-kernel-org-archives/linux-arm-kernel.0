From: dianders@chromium.org (Doug Anderson)
Date: Tue, 29 May 2018 22:23:20 -0700
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
Message-ID: <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, May 22, 2018 at 7:43 PM, David Collins <collinsd@codeaurora.org> wrote:
> +========
> +Examples
> +========
> +
> +#include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> +
> +&apps_rsc {
> +       pm8998-rpmh-regulators {
> +               compatible = "qcom,pm8998-rpmh-regulators";
> +               qcom,pmic-id = "a";
> +
> +               vdd-l7-l12-l14-l15-supply = <&pm8998_s5>;
> +
> +               smps2 {
> +                       regulator-min-microvolt = <1100000>;
> +                       regulator-max-microvolt = <1100000>;
> +               };
> +
> +               pm8998_s5: smps5 {
> +                       regulator-min-microvolt = <1904000>;
> +                       regulator-max-microvolt = <2040000>;
> +               };
> +
> +               ldo7 {
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-initial-mode = <RPMH_REGULATOR_MODE_LPM>;
> +                       regulator-allowed-modes =
> +                               <RPMH_REGULATOR_MODE_LPM
> +                                RPMH_REGULATOR_MODE_HPM>;
> +                       regulator-allow-set-load;
> +                       qcom,regulator-drms-modes =
> +                               <RPMH_REGULATOR_MODE_LPM
> +                                RPMH_REGULATOR_MODE_HPM>;
> +                       qcom,drms-mode-max-microamps = <10000 1000000>;

Things look pretty good to me now.  I'm still hesitant about the whole
need to list the modes twice (once using the unordered
"regulator-allowed-modes" and once to match up against the ordered
"qcom,drms-mode-max-microamps").  I'm also still of the opinion that
the whole "drms-mode-max-microamps" ought to be a standard property
(not a qcom specific one) and handled in the regulator core.

However, for both of these things I leave it to the discretion of Mark
to choose what he wants.  Thus assuming Mark is OK with these two
things, feel free to add my Reviewed-by.

-Doug
