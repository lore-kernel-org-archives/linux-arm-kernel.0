From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Fri, 13 Jun 2014 21:58:17 -0500
Subject: [PATCH] clk: socfpga: Add a second parent option for the
 dbg_base_clk
In-Reply-To: <1402712483-2784-1-git-send-email-dinguyen@altera.com>
References: <1402712483-2784-1-git-send-email-dinguyen@altera.com>
Message-ID: <539BBA49.5020104@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 6/13/14 9:21 PM, dinguyen at altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
>
> The debug base clock can be bypassed from the main PLL to the OSC1 clock.
> The bypass register is the staysoc1(0x10) register that is in the clock
> manager.
>
> This patch adds the option to get the correct parent for the debug base
> clock.
>
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> ---
>  arch/arm/boot/dts/socfpga.dtsi   |    2 +-
>  drivers/clk/socfpga/clk-periph.c |    9 +++++++++
>  drivers/clk/socfpga/clk.h        |    1 +
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
>
Please dis-regard this patch. I forgot to update the socfpga_periph_init()
function to support having multiple parents. I'll send a v2 shortly.

Sorry for the noise.

Dinh
