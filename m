From: robh@kernel.org (Rob Herring)
Date: Tue, 22 May 2018 12:22:38 -0500
Subject: [PATCH V3 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <1526890046-10565-9-git-send-email-christophe.roullier@st.com>
References: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
 <1526890046-10565-9-git-send-email-christophe.roullier@st.com>
Message-ID: <20180522172238.GA26145@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2018 at 10:07:26AM +0200, Christophe Roullier wrote:
> This patch describes syscon DT bindings.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
> index 6808ed9..e46ebad 100644
> --- a/Documentation/devicetree/bindings/arm/stm32.txt
> +++ b/Documentation/devicetree/bindings/arm/stm32.txt
> @@ -8,3 +8,8 @@ using one of the following compatible strings:
>    st,stm32f746
>    st,stm32h743
>    st,stm32mp157
> +
> +Required nodes:
> +- syscon: the soc bus node must have a system controller node pointing to the
> +  global control registers, with the compatible string
> +  "st,stm32mp157-syscfg", "syscon";

Please don't mix soc/board bindings with other nodes. So perhaps 
stm32-syscon.txt.

Rob
