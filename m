From: EXT-Eugeny.Kuznetsov@nokia.com (Evgeny Kuznetsov)
Date: Wed, 13 Oct 2010 14:04:49 +0400
Subject: [PATCHv2 0/1] omap: Ptr "isr_reg" tracked as NULL was dereferenced
Message-ID: <cover.1286961160.git.EXT-Eugeny.Kuznetsov@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here is second version of patch which fixes bug in 
/arch/arm/plat-omap/gpio.c file.
Pointer which may have NULL value in some cases (depend on kernel
configuration and GPIO method) is dereferenced later in code.

I removed BUG() macro to do not halt code execution accoding to comments.
And added WARN_ON() macro and exit from function if pointer "isr_reg" is NULL.
Also compilation check is added for correct architecture
configuration.

Thanks,
Evgeny

Evgeny Kuznetsov (1):
  omap: Ptr "isr_reg" tracked as NULL was dereferenced

 arch/arm/plat-omap/gpio.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)
