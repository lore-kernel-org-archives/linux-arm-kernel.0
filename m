From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 26 Oct 2012 11:43:56 +0100
Subject: [PATCH] ARM: dma-mapping: support debug_dma_mapping_error
In-Reply-To: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
References: <1350909843-5273-1-git-send-email-ming.lei@canonical.com>
Message-ID: <20121026104355.GB21164@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 22, 2012 at 08:44:03PM +0800, Ming Lei wrote:
> Without the patch, kind of below warning will be dumped if DMA-API
> debug is enabled:
> 
> [   11.069763] ------------[ cut here ]------------
> [   11.074645] WARNING: at lib/dma-debug.c:948 check_unmap+0x770/0x860()
> [   11.081420] ehci-omap ehci-omap.0: DMA-API: device driver failed to
> check map error[device address=0x0000000
> 0adb78e80] [size=8 bytes] [mapped as single]
> [   11.095611] Modules linked in:
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Ming Lei <ming.lei@canonical.com>

Would you mind explaining why you think it's fine to send a patch for the
mainline kernel adding a function call to a header file which is not even
in the mainline kernel?

My guess is that the Canonical kernel has some additional checking here
which mainline kernels don't have, which means your patch should never have
been submitted (or even applied.)

On Marek's side, why didn't you try to build your tree at least once in
the last 3 days before pushing this patch to Linus?
