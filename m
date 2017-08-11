From: yao.qi@arm.com (Yao Qi)
Date: Fri, 11 Aug 2017 08:46:28 +0100
Subject: [PATCH 07/11] arm64: add basic pointer authentication support
In-Reply-To: <1500480092-28480-8-git-send-email-mark.rutland@arm.com>
References: <1500480092-28480-1-git-send-email-mark.rutland@arm.com>
 <1500480092-28480-8-git-send-email-mark.rutland@arm.com>
Message-ID: <5a919df5-7f6d-2c6c-9c8e-e28fcebd4920@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On 19/07/17 17:01, Mark Rutland wrote:
> +#define HWCAP_APIA           (1 << 16)

Can you rename it to HWCAP_ARM64_APIA or HWCAP_ARM_APIA?  When we
use it in user space,@least in GDB, we usually do this,

#ifndef HWCAP_APIA
#define HWCAP_APIA (1 << 16)
#endif

However, the code use this macro can be compiled on !arm64 host.
If HWCAP_APIA is defined on other !arm64 host and its value is not
(1 << 16), the program "aarch64_hwcap & HWCAP_APIA ? XXX : XXX;" is
wrong, and compiler doesn't complain.

I notice that mips, mn10300, sparc, and s390 define their HWCAP this
way, like HWCAP_SPARC_FLUSH, HWCAP_MIPS_R6, HWCAP_S390_DFP, etc.
IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you.
