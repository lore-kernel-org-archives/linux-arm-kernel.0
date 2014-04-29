From: mturquette@linaro.org (Mike Turquette)
Date: Tue, 29 Apr 2014 00:07:37 -0700
Subject: [PATCH 4/4] devicetree: bindings: qcom,
 mmcc: Document GDSC binding
In-Reply-To: <1396637136-29974-5-git-send-email-sboyd@codeaurora.org>
References: <1396637136-29974-1-git-send-email-sboyd@codeaurora.org>
 <1396637136-29974-5-git-send-email-sboyd@codeaurora.org>
Message-ID: <20140429070737.7224.72350@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2014-04-04 11:45:36)
> +Example:
> +       clock-controller at 4000000 {
> +               compatible = "qcom,mmcc-msm8974";
> +               reg = <0x4000000 0x1000>;
> +               #clock-cells = <1>;
> +               #reset-cells = <1>;
> +
> +               regulators {
> +                       gdsc_oxili_gx: gdsc_oxili_gx {
> +                               regulator-name = "gdsc_oxili_gx";

Hi Stephen,

It makes sense to model the gdsc's as regulators. It also makes sense to
nest them within the clock-controller node, assuming that matches the
register manual for your part.

However, does it make sense to put this new code under drivers/clk/qcom?
I don't see a compelling reason. How about breaking the registers out
into a header for easier reuse?

Regards,
Mike

> +                               parent-supply = <&pm8841_s4>;
> +                               qcom,retain-mem;
> +                               qcom,retain-periph;
> +                               qcom,skip-logic-collapse;
> +                               qcom,support-hw-trigger;
> +                       };
> +               };
> +       };
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> hosted by The Linux Foundation
> 
