From: bp@alien8.de (Borislav Petkov)
Date: Tue, 6 Nov 2018 11:03:30 +0100
Subject: [PATCH v10 0/6] EDAC: Enhancements to Synopsys EDAC driver
In-Reply-To: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
Message-ID: <20181106100329.GC13712@zn.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 25, 2018 at 11:36:55AM +0530, Manish Narani wrote:
> Change in v10:
> 	- Moved the checking for ce_cnt and ue_cnt before the readl() call
> 	- Aligned arguments on the opening brace in setup_irq()
> 
> Manish Narani (6):
>   edac: synopsys: Add error handling for NULL in probe()
>   dt: bindings: Document ZynqMP DDRC in Synopsys documentation
>   edac: synopsys: Add macro defines for ZynqMP DDRC
>   edac: synopsys: Add EDAC ECC support for ZynqMP DDRC
>   arm64: zynqmp: Add DDRC node
>   edac: synopsys: Add Error Injection support for ZynqMP DDRC
> 
>  .../bindings/memory-controllers/synopsys.txt       |  27 +-
>  arch/arm64/boot/dts/xilinx/zynqmp.dtsi             |   7 +
>  drivers/edac/Kconfig                               |   2 +-
>  drivers/edac/synopsys_edac.c                       | 911 ++++++++++++++++++++-
>  4 files changed, 918 insertions(+), 29 deletions(-)

Ok, patches pushed here:

(minus https://lkml.kernel.org/r/1540447621-22870-6-git-send-email-manish.narani at xilinx.com)

https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/log/?h=edac-for-4.21-synps

Please run this on the hw before I queue it for linux-next.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
