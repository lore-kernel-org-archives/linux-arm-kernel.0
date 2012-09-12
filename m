From: davidb@codeaurora.org (David Brown)
Date: Wed, 12 Sep 2012 09:07:10 -0700
Subject: [PATCH 3/9] ARM: msm: Add DT support to msm_timer
In-Reply-To: <1346873339-10927-4-git-send-email-sboyd@codeaurora.org>
References: <1346873339-10927-1-git-send-email-sboyd@codeaurora.org>
 <1346873339-10927-4-git-send-email-sboyd@codeaurora.org>
Message-ID: <20120912160710.GA21878@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 05, 2012 at 12:28:53PM -0700, Stephen Boyd wrote:

> diff --git a/Documentation/devicetree/bindings/arm/msm/timer.txt b/Documentation/devicetree/bindings/arm/msm/timer.txt

> +       timer at 0200a004 {
> +               compatible = "qcom,msm-gpt", "qcom,msm-timer";
> +               interrupts = <1 2 0x301>;
> +               reg = <0x0200a004 0x10>;
> +               clock-frequency = <32768>;
> +               cpu-offset = <0x40000>;
> +       };
> +
> +       timer at 0200a024 {
> +               compatible = "qcom,msm-dgt", "qcom,msm-timer";
> +               interrupts = <1 3 0x301>;
> +               reg = <0x0200a024 0x10>,
> +                     <0x0200a034 0x4>;
> +               clock-frequency = <6750000>;
> +               cpu-offset = <0x40000>;
> +       };

The names should be timer at 200a004 and timer at 200a024, without the
leading zero.  If there are no other concerns, I can just fix these up
when I pull the patch in.  No need to resend.

Thanks,
David

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
