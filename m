From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Wed, 12 Nov 2014 01:33:06 -0600
Subject: [PATCHv5 2/5] arm: socfpga: Enable OCRAM ECC on startup.
In-Reply-To: <1415751263-1830-3-git-send-email-tthayer@opensource.altera.com>
References: <1415751263-1830-1-git-send-email-tthayer@opensource.altera.com>
 <1415751263-1830-3-git-send-email-tthayer@opensource.altera.com>
Message-ID: <54630D32.1000307@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/11/14, 6:14 PM, tthayer at opensource.altera.com wrote:
> From: Thor Thayer <tthayer@opensource.altera.com>
> 
> This patch enables the ECC for On-Chip RAM on machine
> startup.  The ECC has to be enabled before data is
> is stored in memory otherwise the ECC will fail on
> reads.
> 
> Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
> ---
> v2: Split OCRAM ECC portion separately. Addition of iounmap()
> and reorganization of gen_pool_free. Remove defconfig from patch.
> 
> v3/4: No change
> 
> v5: Remove ocram.h, use io.h instead of clk-provider.h
>     Check prop in correct place. Add ECC EN defines.
> ---
>  arch/arm/mach-socfpga/Makefile  |    1 +
>  arch/arm/mach-socfpga/core.h    |    1 +
>  arch/arm/mach-socfpga/ocram.c   |   90 +++++++++++++++++++++++++++++++++++++++
>  arch/arm/mach-socfpga/socfpga.c |    9 ++++
>  4 files changed, 101 insertions(+)
>  create mode 100644 arch/arm/mach-socfpga/ocram.c
> 

Acked-by: Dinh Nguyen <dinguyen@opensource.altera.com>
