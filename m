From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 24 Jan 2017 21:27:35 +0800
Subject: [PATCH v3] ARM: dts: imx: Pass 'chosen' and 'memory' nodes
In-Reply-To: <1485190450-29153-1-git-send-email-festevam@gmail.com>
References: <1485190450-29153-1-git-send-email-festevam@gmail.com>
Message-ID: <20170124132733.GY5662@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 02:54:10PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Commit 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi") causes boot
> issues when the bootloader does not create a 'chosen' node if such node
> is not present in the dtb.
> 
> The reason for the boot failure is well explained by Javier Martinez
> Canillas: "the decompressor relies on a pre-existing chosen node to be
> available to insert the command line and merge other ATAGS info."
> 
> , so pass an empty 'chosen' node to fix the boot problem.
> 
> This issue has been seen in the kernelci reports with Barebox as
> bootloader.
> 
> Also pass the 'memory' node in order to fix boot issues on the SolidRun
> iMX6 platforms.
> 
> Fixes: 7f107887d199 ("ARM: dts: imx: Remove skeleton.dtsi")
> Reported-by: kernelci.org bot <bot@kernelci.org>
> Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied, thanks.
