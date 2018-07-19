From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 19 Jul 2018 10:24:26 +0800
Subject: [PATCH V2] soc: imx: gpc: restrict register range for regmap
 access
In-Reply-To: <1531798126-24360-1-git-send-email-Anson.Huang@nxp.com>
References: <1531798126-24360-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <20180719022424.GO4576@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2018 at 11:28:46AM +0800, Anson Huang wrote:
> GPC registers are NOT continuous, some registers are
> reserved and accessing them from userspace will trigger
> external abort, add regmap register access table to
> avoid below abort:
> 
> root at imx6slevk:~# cat /sys/kernel/debug/regmap/20dc000.gpc/registers
> [  108.480477] Unhandled fault: imprecise external abort (0x1406) at 0xb6db5004
> [  108.487985] pgd = 42b54bfd
> [  108.490741] [b6db5004] *pgd=ba1b7831
> [  108.494386] Internal error: : 1406 [#1] SMP ARM
> [  108.498943] Modules linked in:
> [  108.502043] CPU: 0 PID: 389 Comm: cat Not tainted 4.18.0-rc1-00074-gc9f1f60-dirty #482
> [  108.509982] Hardware name: Freescale i.MX6 SoloLite (Device Tree)
> [  108.516123] PC is at regmap_mmio_read32le+0x20/0x24
> [  108.521031] LR is at regmap_mmio_read+0x40/0x60
> [  108.525586] pc : [<c059cf74>]    lr : [<c059d1ac>]    psr: 20060093
> [  108.531875] sp : eccf1d98  ip : eccf1da8  fp : eccf1da4
> [  108.537122] r10: ec2d3800  r9 : eccf1f60  r8 : ecfc0000
> [  108.542370] r7 : eccf1e2c  r6 : eccf1e2c  r5 : 00000028  r4 : ec338e00
> [  108.548920] r3 : 00000000  r2 : eccf1e2c  r1 : f0980028  r0 : 00000000
> [  108.555474] Flags: nzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  108.562720] Control: 10c5387d  Table: acf4004a  DAC: 00000051
> [  108.568491] Process cat (pid: 389, stack limit = 0xd4318a65)
> [  108.574174] Stack: (0xeccf1d98 to 0xeccf2000)
> 
> Fixes: 721cabf6c660 ("soc: imx: move PGC handling to a new GPC driver")
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
