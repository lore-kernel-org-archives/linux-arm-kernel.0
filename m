From: timur@codeaurora.org (Timur Tabi)
Date: Wed, 04 Feb 2015 10:16:34 -0600
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <1423066107.18187.99.camel@deneb.redhat.com>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>	
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>	
 <2422968.Es7R0p3loO@vostro.rjw.lan>	
 <1422984576.18187.82.camel@deneb.redhat.com>	
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
Message-ID: <54D245E2.2030003@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/04/2015 10:08 AM, Mark Salter wrote:
> acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> which are already included in the kernel's linear RAM mapping. So we
> need ioremap_cache to avoid two mappings to the same physical page
> having different caching attributes.

Would it be possible to modify ioremap() so that it can tell whether the 
memory is already mapped in some way, and then use a compatible remapping?

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
