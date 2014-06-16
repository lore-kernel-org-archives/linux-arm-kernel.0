From: maxime.coquelin@st.com (Maxime Coquelin)
Date: Mon, 16 Jun 2014 13:28:05 +0200
Subject: [PATCH V2] ARM: STi: DT: Properly define sti-ethclk & stmmaceth
 for stih415/6
In-Reply-To: <20140616092339.GB27978@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1402345355-5682-1-git-send-email-peter.griffin@linaro.org>
 <20140616092339.GB27978@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <539ED4C5.4070906@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Peter,

On 06/16/2014 11:23 AM, Peter Griffin wrote:
> This patch fixes two problems: -
>
> 1) The device tree isn't currently providing sti-ethclk which is
> required by the dwmac glue code to correctly configure the ethernet
> PHY clock speed.
>
> This means depending on what the bootloader/jtag has
> configured this clock to, and what switch/hub the board is plugged
> into you most likely will NOT successfully negotiate a ethernet link.
>
> 2) The stmmaceth clock was associated with the wrong clock. It was
> referencing the PHY clock rather than the interconnect clock which
> clocks the IP.
>
> This patch also brings us closer to not having to boot the upstream
> kernel with the clk_ignore_unused parameter.
>
> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> ---
>   arch/arm/boot/dts/stih415.dtsi           | 8 ++++----
>   arch/arm/boot/dts/stih416.dtsi           | 8 ++++----
>   include/dt-bindings/clock/stih415-clks.h | 1 +
>   include/dt-bindings/clock/stih416-clks.h | 1 +
>   4 files changed, 10 insertions(+), 8 deletions(-)
>

...

Acked-by: Maxime Coquelin <maxime.coquelin@st.com>

Thanks for the fix!

Maxime
