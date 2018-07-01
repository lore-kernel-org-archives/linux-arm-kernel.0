From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 1 Jul 2018 11:17:41 +0800
Subject: [PATCH] ARM: imx51: Add aipstz nodes
In-Reply-To: <1529517979-6406-1-git-send-email-festevam@gmail.com>
References: <1529517979-6406-1-git-send-email-festevam@gmail.com>
Message-ID: <20180701031740.GE4348@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2018 at 03:06:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@nxp.com>
> 
> Currently when trying to use the 'devmem' tool to read/write
> registers the following bus error is observed:
> 
> # devmem 0x73fa80c4 32
> [   82.689185] Unhandled fault: external abort on non-linefetch (0x1018) at 0xb6ff10c4
> [   82.697071] pgd = (ptrval)
> [   82.699920] [b6ff10c4] *pgd=a87c5831, *pte=73fa8383, *ppte=73fa8a33
> Bus error
> 
> Add the aipstz nodes, so that the following function from
> imx51_dt_init() can work properly:
> 
> 	imx_aips_allow_unprivileged_access("fsl,imx51-aipstz");
> 
> After adding these nodes, 'devmem' tool can work correctly,
> which is very useful for debugging purposes.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied with changing prefix to 'ARM: dts: imx51: ...'.

Shawn
