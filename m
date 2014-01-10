From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 10 Jan 2014 10:44:03 +0800
Subject: [PATCH 1/2] Revert "ARM: dts: imx: use dual-fifo sdma script for
 ssi"
In-Reply-To: <1389170756-22351-2-git-send-email-Guangyu.Chen@freescale.com>
References: <1389170756-22351-1-git-send-email-Guangyu.Chen@freescale.com>
 <1389170756-22351-2-git-send-email-Guangyu.Chen@freescale.com>
Message-ID: <20140110024359.GB6844@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 04:45:55PM +0800, Nicolin Chen wrote:
> This reverts commit b1d27c79c8377df1880447375deffa3bb82c7bd3.
> 
> Previously we switched the SSI scriprt to dual-fifo mode to reduce playback
> underrun issue, which is only included by SDMA firmware version 2. However,
> there are quite a lot people still using version 1 or default firmware in
> the ROM code of SoC while these two kinds of firmwares do not support the
> dual-fifo script and the audio function on their platform would be broken.
> 
> Thus this patch provisionally reverts the dual-fifo script to the original
> single fifo script to meet all kinds of users' requirements, including the
> version 1/2 or inner ROM firmware.
> 
> Reported-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Nicolin Chen <Guangyu.Chen@freescale.com>

If Vinod's tree can be rebased, the patch can just be dropped.
Otherwise,

Acked-by: Shawn Guo <shawn.guo@linaro.org>
