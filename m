From: robh@kernel.org (Rob Herring)
Date: Sat, 16 Jul 2016 14:25:22 -0500
Subject: [PATCH] pinctrl: qcom: Add generic ssbi and spmi GPIO/MPP bindings
In-Reply-To: <20160711190109.16758-1-sboyd@codeaurora.org>
References: <20160711190109.16758-1-sboyd@codeaurora.org>
Message-ID: <20160716192522.GA8272@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 11, 2016 at 12:01:09PM -0700, Stephen Boyd wrote:
> The drivers don't really need to know which PMIC they're for, so
> make a generic binding for them. This alleviates us from updating
> the drivers every time a new PMIC comes out. It's still
> recommended that we update the binding with new PMIC models and
> always specify the specific model for the MPPs and gpios before
> the generic compatible string in devicetree, but this at least
> cuts down on adding more and more compatible strings to the
> drivers until we actually need them.
> 
> Cc: <devicetree@vger.kernel.org>
> Acked-by: "Ivan T. Ivanov" <iivanov.xz@gmail.com>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
> 
> This seems to been missed 6 months ago when sent as an RFC. The dts
> side changes have already been made and Rob H said it "Seems okay to
> me".
> 
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.txt | 5 ++++-
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-mpp.txt  | 5 ++++-
>  drivers/pinctrl/qcom/pinctrl-spmi-gpio.c                     | 1 +
>  drivers/pinctrl/qcom/pinctrl-spmi-mpp.c                      | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
