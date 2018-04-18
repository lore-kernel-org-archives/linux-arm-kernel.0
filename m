From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 18 Apr 2018 11:08:25 +0800
Subject: [PATCHv2] ARM: dts: imx6ull: add UART5 input select register
 definitions
In-Reply-To: <1522246943-2269-1-git-send-email-gerg@linux-m68k.org>
References: <1522246943-2269-1-git-send-email-gerg@linux-m68k.org>
Message-ID: <20180418030824.GQ25429@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 29, 2018 at 12:22:23AM +1000, Greg Ungerer wrote:
> The iMX6ULL UART5_RX_DATA_SELECT_INPUT DAISY Register has some different
> bit definitions to that same register in the iMX6UL.
> 
> The bits for the iMX6UL:
> 
> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
> 100 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT
> 101 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT
> 
> But for the iMX6ULL:
> 
> 000 CSI_DATA00_ALT8 ? Selecting Pad: CSI_DATA00 for Mode: ALT8
> 001 CSI_DATA01_ALT8 ? Selecting Pad: CSI_DATA01 for Mode: ALT8
> 010 GPIO1_IO04_ALT8 ? Selecting Pad: GPIO1_IO04 for Mode: ALT8
> 011 GPIO1_IO05_ALT8 ? Selecting Pad: GPIO1_IO05 for Mode: ALT
> 100 UART1_TX_DATA_ALT9 ? Selecting Pad: UART1_TX_DATA for Mode: ALT9
> 101 UART1_RX_DATA_ALT9 ? Selecting Pad: UART1_RX_DATA for Mode: ALT9
> 110 UART5_TX_DATA_ALT0 ? Selecting Pad: UART5_TX_DATA for Mode: ALT0
> 111 UART5_RX_DATA_ALT0 ? Selecting Pad: UART5_RX_DATA for Mode: ALT0
> 
> Specifically for a board I am working on with the serial console on UART5
> I need to be able to enable UART5_RX_DATA_ALT0 mode. There is no definition
> for the iMX6ULL version of that in imx6ul-pinfunc.h or imx6ull-pinfunc.h.
> 
> Add definitions for the missing UART5 input select register bits of the
> iMX6ULL.
> 
> Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>

Applied, thanks.
