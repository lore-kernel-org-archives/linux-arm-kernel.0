From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Feb 2018 15:22:24 +0800
Subject: [PATCH] ARM: dts: imx6ul: rename mux mode name REF_CLK_32K to
 OSC32K_32K_OUT
In-Reply-To: <20180205204759.28526-1-joerg.krause@embedded.rocks>
References: <20180205204759.28526-1-joerg.krause@embedded.rocks>
Message-ID: <20180208072222.GE31910@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 09:47:59PM +0100, J?rg Krause wrote:
> This is a rebased version of patch [0].
> 
> The 32 kHz reference clock on the i.MX6UL(L) can be output by
> setting the external signal XTALOSC_REF_CLK_32K in one of the
> following ways [1]:
> 
> |----------------------------------------------------------|
> | Signal              | Pad             | Mode | Direction |
> |----------------------------------------------------------|
> | XTALOSC_REF_CLK_32K | ENET1_RX_EN     | ALT2 | O         |
> |                     | GPIO1_IO03      | ALT3 |           |
> |                     | JTAG_TCK        | ALT6 |           |
> |----------------------------------------------------------|
> 
> Before patch [2] the mux mode for the external reference clock was
> missing. The patch named the mux mode as used in the NXP Linux
> 4.9.11_1.0.0 release, but the Reference Manual uses the name
> OSC32K_32K_OUT, e.g. in [3].
> 
> As Philipp and Shawn suggest the name from the RM should be used
> instead.
> 
> [0] https://patchwork.kernel.org/patch/10172187/
> [1] IMX6ULRM, Rev. 1, 04/2016, Table 58-1, p. 3649
> [2] https://patchwork.kernel.org/patch/10156121/
> [3] IMX6ULRM, Rev. 1, 04/2016, 30.5.47 SW_MUX_CTL_PAD_ENET1_RX_EN SW MUX
>     Control Register (IOMUXC_SW_MUX_CTL_PAD_ENET1_RX_EN), p. 1357
> 
> Signed-off-by: J?rg Krause <joerg.krause@embedded.rocks>

Applied, thanks.
