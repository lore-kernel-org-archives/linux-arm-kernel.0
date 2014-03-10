From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 10 Mar 2014 11:54:23 +0000
Subject: [PATCH 4/5] ARM: STi: DT: add keyscan for stih41x-b2000
In-Reply-To: <1393990772-9567-5-git-send-email-gabriel.fernandez@st.com>
References: <1393990772-9567-1-git-send-email-gabriel.fernandez@st.com>
 <1393990772-9567-5-git-send-email-gabriel.fernandez@st.com>
Message-ID: <20140310115423.GR14976@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Mar 2014, Gabriel FERNANDEZ wrote:

> Add keyscan setup for stih415/h416 b2000.
> Both have same raw/column lines number, debounce time and keymap.
> 
> Signed-off-by: Giuseppe Condorelli <giuseppe.condorelli@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  arch/arm/boot/dts/stih41x-b2000.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stih41x-b2000.dtsi b/arch/arm/boot/dts/stih41x-b2000.dtsi
> index 1e6aa92..cf06beb 100644
> --- a/arch/arm/boot/dts/stih41x-b2000.dtsi
> +++ b/arch/arm/boot/dts/stih41x-b2000.dtsi
> @@ -6,6 +6,7 @@
>   * it under the terms of the GNU General Public License version 2 as
>   * publishhed by the Free Software Foundation.
>   */
> +#include <dt-bindings/input/input.h>
>  / {
>  
>  	memory{
> @@ -46,5 +47,16 @@
>  
>  			status = "okay";
>  		};
> +
> +		keyscan: keyscan at fe4b0000 {
> +			keypad,num-rows = <4>;
> +			keypad,num-columns = <4>;
> +			st,debounce_us = <5000>;
> +			linux,keymap = < /* in0	in1	in2	in3 */

Nit: We should try to line the headers up with their associated values
(perhaps they just look misalined in the email and are actually fine
in the text file?)

> +				KEY_F13 KEY_F9  KEY_F5 KEY_F1		/* out0 */
> +				KEY_F14 KEY_F10 KEY_F6 KEY_F2		/* out1 */
> +				KEY_F15 KEY_F11 KEY_F7 KEY_F3		/* out2 */
> +				KEY_F16 KEY_F12 KEY_F8 KEY_F4 >;	/* out3 */
> +		};

Patch looks good though:
  Acked-by: Lee Jones <lee.jones@linaro.org>

>  	};
>  };

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
