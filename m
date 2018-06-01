From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 1 Jun 2018 10:45:58 -0400
Subject: [PATCH] PCI: move early dump functionality from x86 arch into the
 common code
In-Reply-To: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
References: <1527654876-26716-1-git-send-email-okaya@codeaurora.org>
Message-ID: <82d0852b-7c34-3fc2-85d8-c21b33aa8cf4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/30/2018 12:34 AM, Sinan Kaya wrote:
> Move early dump functionality into common code so that it is available for
> all archtiectures. No need to carry arch specific reads around as the read
> hooks are already initialized by the time pci_setup_device() is getting
> called during scan.
> 
> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt |  2 +-
>  arch/x86/include/asm/pci-direct.h               |  5 ---
>  arch/x86/kernel/setup.c                         |  5 ---
>  arch/x86/pci/common.c                           |  4 --
>  arch/x86/pci/early.c                            | 50 -------------------------
>  drivers/pci/pci.c                               |  4 ++
>  drivers/pci/pci.h                               |  2 +-
>  drivers/pci/probe.c                             | 19 ++++++++++
>  8 files changed, 25 insertions(+), 66 deletions(-)

Any feedback on the direction?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
