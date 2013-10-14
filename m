From: monstr@monstr.eu (Michal Simek)
Date: Mon, 14 Oct 2013 11:04:55 +0200
Subject: [PATCH v2 1/2] clk/zynq/clkc: Add 'fclk-enable' feature
In-Reply-To: <1381425018-5653-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1381425018-5653-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <525BB3B7.7000802@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2013 07:10 PM, Soren Brinkmann wrote:
> In some use cases Zynq's FPGA clocks are used as static clock
> generators for IP in the FPGA part of the SOC for which no Linux driver
> exists and would control those clocks. To avoid automatic
> gating of these clocks in such cases a new property - fclk-enable - is
> added to the clock controller's DT description to accomodate such use
> cases. It's value is a bitmask, where a set bit results in enabling
> the corresponding FCLK through the clkc.
> 
> FPGA clocks are handled following the rules below:
> 
> If an FCLK is not enabled by bootloaders, that FCLK will be disabled in
> Linux. Drivers can enable and control it through the CCF as usual.
> 
> If an FCLK is enabled by bootloaders AND the corresponding bit in the
> 'fclk-enable' DT property is set, that FCLK will be enabled by the clkc,
> resulting in an off by one reference count for that clock. Ensuring it
> will always be running.
> 
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> ---
> v2:
>  - change default value for fclk-enable to '0'
> ---
>  Documentation/devicetree/bindings/clock/zynq-7000.txt |  4 ++++
>  drivers/clk/zynq/clkc.c                               | 18 +++++++++++++++---
>  2 files changed, 19 insertions(+), 3 deletions(-)

For both patches:
Acked-by: Michal Simek <michal.simek@xilinx.com>

Mike: Can you please add both these patches to your tree?
There shouldn't be any conflict with DT patch itself.
But if you don't want to add 2/2 through your tree, I am also fine
with taking this through my zynq tree.

Thanks,
Michal

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Microblaze cpu - http://www.monstr.eu/fdt/
Maintainer of Linux kernel - Xilinx Zynq ARM architecture
Microblaze U-BOOT custodian and responsible for u-boot arm zynq platform


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 263 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131014/3feca7a2/attachment.sig>
