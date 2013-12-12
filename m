From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Thu, 12 Dec 2013 10:47:58 +0100
Subject: [PATCH CFT] ARM:S5P64X0: Enable ARM_PATCH_PHYS_VIRT and
 AUTO_ZRELADDR by default
In-Reply-To: <1386825152-398-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
References: <1386825152-398-1-git-send-email-panchaxari.prasannamurthy@linaro.org>
Message-ID: <26167386.hX5eWUjT6T@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi panchaxari,

On Thursday 12 of December 2013 10:42:32 panchaxari wrote:
> ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR have been enabled as default configs
> to S5P64X0 platforms.
> 
> Introduction of PHYS_VIRT config as default would enable phy-to-virt and
> virt-to-phy translation function at boot and module loading time
> and enforce dynamic reallocation of memory. AUTO_ZRELADDR config would
> enable calculation of kernel load address at run time.
> 
> PHYS_VIRT config is mutually exclusive to XIP_KERNEL, XIP_KERNEL is used in
> systems with NOR flash devices, and ZRELADDR config is mutually exclusive
> to ZBOOT_ROM.
> 
> CFT::Call For Testing
> 
> Requesting maintainers of S5P64X0 platforms to evaluate the changes on the
> board and comment, as I dont have the board for testing and also requesting
> an ACK

Could you explain the purpose of this change on S5P64x0?

This is actually quite a poor platform choice. As of today, the kernel
is stuck with supporting just SMDK6440/6450 boards, which are proprietary
development boards and it doesn't look like any further boards will show
up in future. Kukjin has actually proposed removing support for this
platform at all and I consider this reasonable.

Kukjin, should we proceed with removal?

Best regards,
Tomasz
