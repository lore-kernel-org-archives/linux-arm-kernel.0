From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 21 Jan 2013 17:46:48 -0500 (EST)
Subject: [PATCH] crypto: fix FTBFS with ARM SHA1-asm and THUMB2_KERNEL
In-Reply-To: <1358787763-1226-1-git-send-email-matt@genesi-usa.com>
References: <1358787763-1226-1-git-send-email-matt@genesi-usa.com>
Message-ID: <alpine.LFD.2.02.1301211739470.6300@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Jan 2013, Matt Sealey wrote:

> The optimized assembler SHA1 code for ARM does not conform to Thumb2
> register usage requirements, so it cannot be built when the kernel is
> configured with THUMB2_KERNEL.
> 
> Fix the FTBFS for now by preventing misconfigurations of the kernel.
> 
> Signed-off-by: Matt Sealey <matt@genesi-usa.com>

A .arm directive at the top of the assembly code would be a better 
"fix", as that wouldn't reduce functionality.

Yet, I'd invite you to have a look at commit 638591cd7b in linux-next.


Nicolas
