From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 22 Apr 2014 13:10:42 +0200
Subject: [PATCH] clk: zynq: Leave debug clocks in bootup state
In-Reply-To: <1397760052-3310-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1397760052-3310-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <9b50f9f9-0a8a-43a7-8d23-5f8f81b62a54@CO9EHSMHS015.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 08:40 PM, Soren Brinkmann wrote:
> Make sure debug clocks stay enabled if the bootloader enabled them.
> Otherwise debug HW may crash due to bus-hangs caused by stopped clocks.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
>  drivers/clk/zynq/clkc.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
> index 52c09afdcfb7..246cf1226eaa 100644
> --- a/drivers/clk/zynq/clkc.c
> +++ b/drivers/clk/zynq/clkc.c
> @@ -53,6 +53,9 @@ static void __iomem *zynq_clkc_base;

Applied to zynq/clk.

Thanks,
Michal
