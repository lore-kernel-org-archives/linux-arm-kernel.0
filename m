From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 21 May 2015 08:39:26 +0800
Subject: [PATCH] ARM: imx: clk-vf610: enable debug access port by default
In-Reply-To: <1431900813-5466-1-git-send-email-stefan@agner.ch>
References: <1431900813-5466-1-git-send-email-stefan@agner.ch>
Message-ID: <20150521003924.GE24844@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 12:13:33AM +0200, Stefan Agner wrote:
> Enabled DAP (debug access port) by default. This enables the hw-
> breakpoint framework to make use of the breakpoints and watchpoints
> supported by hardware.
> 
> [    0.215805] hw-breakpoint: found 2 (+1 reserved) breakpoint and 1 watchpoint registers.
> [    0.224624] hw-breakpoint: maximum watchpoint size is 4 bytes.
> 
> Without this clock, the hw-breakpoint driver claims an undefined
> instruction during initialization:
> [    0.227380] hw-breakpoint: Debug register access (0xee003e17) caused undefined instruction on CPU 0
> [    0.227519] hw-breakpoint: CPU 0 failed to disable vector catch
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
