From: robh@kernel.org (Rob Herring)
Date: Wed, 30 May 2018 19:14:54 -0500
Subject: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: add gpio-ranges,
 gpio-reserved-ranges
In-Reply-To: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
References: <6dbaadee4bb22638a2c2e6433e8d1740884ecfd9.1527505307.git.chunkeey@gmail.com>
Message-ID: <20180531001454.GA8422@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 01:06:01PM +0200, Christian Lamparter wrote:
> This patch adds the gpio-ranges and gpio-reserved-ranges property
> definitions to the binding text files supported by the pinctrl-msm
> driver framework.
> 
> gpio-ranges:
> For DT-based platforms the pinctrl-msm framework currently relies
> on the deprecated-for-DT gpiochip_add_pin_range() function to add
> the range of GPIOs to be handled by the pin controller. Due to
> interactions within gpiolib code, this causes the pinctrl-msm
> driver to bail out (-517) during boot when a gpio-hog is declared.
> This can be fatal and cause the system to not boot or reset
> (for a detailed explanation and call-trace, refer to patch:
> "pinctrl: msm: fix gpio-hog related boot issues" in this series).
> 
> gpio-reserved-ranges:
> The binding has been added as a precaution since the TrustZone
> firmware (aka QSEE), which is running as the hypervisor, might
> have reserved certain, but undisclosed pins. Hence reading or
> writing to the registers for those pins will cause an
> XPU violation and this subsequently crashes the kernel.
> 
> Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
> ---
>  .../devicetree/bindings/pinctrl/qcom,apq8064-pinctrl.txt | 6 ++++++
>  .../devicetree/bindings/pinctrl/qcom,apq8084-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,ipq4019-pinctrl.txt | 6 ++++++
>  .../devicetree/bindings/pinctrl/qcom,ipq8064-pinctrl.txt | 6 ++++++
>  .../devicetree/bindings/pinctrl/qcom,ipq8074-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,mdm9615-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8660-pinctrl.txt | 6 ++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8916-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8960-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8974-pinctrl.txt | 6 ++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8994-pinctrl.txt | 9 +++++++++
>  .../devicetree/bindings/pinctrl/qcom,msm8996-pinctrl.txt | 9 +++++++++
>  12 files changed, 93 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
