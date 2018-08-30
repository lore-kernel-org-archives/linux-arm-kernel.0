From: toshi.kani@hpe.com (Kani, Toshi)
Date: Thu, 30 Aug 2018 21:29:04 +0000
Subject: [PATCH v2] EDAC, ghes: use CPER module handles to locate DIMMs
In-Reply-To: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
References: <1535654266-40053-1-git-send-email-wufan@codeaurora.org>
Message-ID: <a2b7b914120f1c2e7020d18d7c7d824413e06304.camel@hpe.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-08-30 at 18:37 +0000, Fan Wu wrote:
> For platforms whose firmwares provide valid module handles
> (SMBIOS type 17) in error records, this patch uses the module
> handles to locate corresponding DIMMs and enables per-DIMM
> error counter update.
> 
> Signed-off-by: Fan Wu <wufan@codeaurora.org>

Tested on an HPE x86 server. It turns out that mem_err->mem_dev_handle
was set to  0 with this FW, and get_dimm_smbios_index() returned -1. But
the code handles this case fine. dimm->smbios_handle's were initialized
properly. So:

Tested-by: Toshi Kani <toshi.kani@hpe.com>

Thanks,
-Toshi
