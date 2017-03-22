From: okaya@codeaurora.org (Sinan Kaya)
Date: Wed, 22 Mar 2017 15:36:49 -0400
Subject: [PATCH v3] efifb: avoid reconfiguration of BAR that covers the
 framebuffer
In-Reply-To: <20170322193111.GA8190@wunner.de>
References: <1490196629-28088-1-git-send-email-ard.biesheuvel@linaro.org>
 <20170322193111.GA8190@wunner.de>
Message-ID: <31da6db5-be22-9e84-5e76-67c519bc0b34@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/22/2017 3:31 PM, Lukas Wunner wrote:
> On arm64 PCI systems, the entire PCI hierarchy is reconfigured from
> scratch at boot. This may result in the GOP framebuffer address to
> become stale, if the BAR covering the framebuffer is modified.

Does this code still work with the case where resources are not reassigned on ARM64?

As far as I know, kernel honors resource assignments done by the UEFI BIOS if
they are correct. Kernel will reassign the resources only if something is wrong.

Will this code break other platforms/architectures?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
