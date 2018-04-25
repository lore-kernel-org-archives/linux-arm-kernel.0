From: robh@kernel.org (Rob Herring)
Date: Wed, 25 Apr 2018 10:09:39 -0500
Subject: [PATCH 3/8] ARM: dts: stm32: add ethernet pins to stm32mp157c
In-Reply-To: <1524582120-4451-4-git-send-email-christophe.roullier@st.com>
References: <1524582120-4451-1-git-send-email-christophe.roullier@st.com>
 <1524582120-4451-4-git-send-email-christophe.roullier@st.com>
Message-ID: <CAL_JsqL7bY=OSuzeVHH2UxxaBmCMzpFc8djnuZAY6VWcTgUmZw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:01 AM, Christophe Roullier
<christophe.roullier@st.com> wrote:
> Add ethernet pins on stm32mp157c.
>
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  arch/arm/boot/dts/stm32mp157-pinctrl.dtsi | 46 +++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> index 6f044100..86720a5 100644
> --- a/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/stm32mp157-pinctrl.dtsi
> @@ -158,6 +158,52 @@
>                                         bias-disable;
>                                 };
>                         };
> +
> +                       ethernet0_rgmii_pins_a: rgmii at 0 {

A unit-address without 'reg' property is not valid, so drop the '@0'.

Please build your dtb with W=1 or W=12 which will tell you this and
other errors.

Rob
