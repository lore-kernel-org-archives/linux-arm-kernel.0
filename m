From: matt@console-pimps.org (Matt Fleming)
Date: Wed, 26 Jun 2013 14:32:17 +0100
Subject: [PATCH 2/4] x86: efi: break efi_lookup_mapped_addr out to
 generic code
In-Reply-To: <1372183863-11333-3-git-send-email-leif.lindholm@linaro.org>
References: <1372183863-11333-1-git-send-email-leif.lindholm@linaro.org>
 <1372183863-11333-3-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20130626133217.GO22026@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Jun, at 07:11:01PM, Leif Lindholm wrote:
> efi_lookup_mapped_addr is a handy helper function for translating
> a physical address to the corresponding virtual one by scanning
> through memmap.map.
> 
> This patch breaks it out into a new file for use elsewhere.
> 
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  arch/x86/platform/efi/efi.c       |   28 ----------------------------
>  drivers/firmware/efi/Makefile     |    2 +-
>  drivers/firmware/efi/efi-helper.c |   33 +++++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+), 29 deletions(-)
>  create mode 100644 drivers/firmware/efi/efi-helper.c

I'm not sure this function needs its own file. drivers/firmware/efi/efi.c
is a suitable place for this.

-- 
Matt Fleming, Intel Open Source Technology Center
