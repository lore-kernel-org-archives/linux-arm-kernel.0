From: robh@kernel.org (Rob Herring)
Date: Wed, 25 May 2016 12:24:09 -0500
Subject: [PATCH 02/11] drivers: clk: st: Add clock propagation for audio
 clocks
In-Reply-To: <1463560892-7209-3-git-send-email-gabriel.fernandez@linaro.org>
References: <1463560892-7209-1-git-send-email-gabriel.fernandez@linaro.org>
 <1463560892-7209-3-git-send-email-gabriel.fernandez@linaro.org>
Message-ID: <20160525172409.GA27913@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 18, 2016 at 10:41:23AM +0200, Gabriel Fernandez wrote:
> This patch allows fine tuning of the quads FS for audio clocks
> accuracy.
> 
> Signed-off-by: Olivier Bideau <olivier.bideau@st.com>
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@linaro.org>
> ---
>  .../devicetree/bindings/clock/st/st,flexgen.txt    |  1 +
>  drivers/clk/st/clk-flexgen.c                       | 24 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> index b7ee5c7..15b33c7 100644
> --- a/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> +++ b/Documentation/devicetree/bindings/clock/st/st,flexgen.txt
> @@ -60,6 +60,7 @@ This binding uses the common clock binding[2].
>  Required properties:
>  - compatible : shall be:
>    "st,flexgen"
> +  "st,stih407-clkgend0", "st,flexgen" (enable clock propagation on parent)

What do "d0" and "d2" refer to?

This seems to indicate you have too much clock detail in the DT (with 
individual clocks described) or not enough with genericish compatible 
strings. What happens for the mext clock you need to adjust the flags 
on? You should be able to make these adjustments without DT updates. 
Perhaps you need a wider fixing of clock compatible strings.

Rob
