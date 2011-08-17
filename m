From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 17 Aug 2011 22:38:13 +0800
Subject: [RFC PATCH 0/2] WIP: generic OF pinmux binding
In-Reply-To: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
References: <1313581648-22303-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20110817143811.GA11097@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 12:47:26PM +0100, Jamie Iles wrote:
> To avoid going too far in the wrong direction I thought I'd post what I
> have so far for a generic pinmux binding.

Unfortunately, there is not much that i.mx iomuxc can leverage, even
for mux-function.  The following is the mux configuration for one
i.mx pin/pad.  Other than a string, a integer will work much better.

MUX_MODE (bit 2-0): Select 1 of 7 iomux modes to be used for pad: EIM_DA9.
000 Select mux mode: ALT0 mux port: WEIM_DA_A[9] of instance: weim.
001 Select mux mode: ALT1 mux port: DISP1_DAT[0] of instance: ipu1.
010 Select mux mode: ALT2 mux port: CSI1_D[0] of instance: ipu2.
011 Select mux mode: ALT3 mux port: DPHY_TEST_OUT[11] of instance: mipi_core.
101 Select mux mode: ALT5 mux port: GPIO[9] of instance: gpio3.
110 Select mux mode: ALT6 mux port: HDATA[23] of instance: tpsmp.
111 Select mux mode: ALT7 mux port: BT_CFG[9] of instance: src.

> Essentially it's just
> Stephen's nvidia binding but with the nvidia specifics abstracted out so
> the common loop can be used for other platforms.  This approach works
> nicely for picoxcell too.
> 
> For more esoteric bindings, such as pull strength, these could be
> handled in the platform specific configuration function.
> 

-- 
Regards,
Shawn
