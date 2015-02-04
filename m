From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Feb 2015 17:52:56 +0000
Subject: [PATCH v8 02/21] acpi: fix acpi_os_ioremap for arm64
In-Reply-To: <54D245E2.2030003@codeaurora.org>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <1422881149-8177-3-git-send-email-hanjun.guo@linaro.org>
 <2422968.Es7R0p3loO@vostro.rjw.lan>
 <1422984576.18187.82.camel@deneb.redhat.com>
 <20150204112508.GB26006@e104818-lin.cambridge.arm.com>
 <1423066107.18187.99.camel@deneb.redhat.com>
 <54D245E2.2030003@codeaurora.org>
Message-ID: <20150204175256.GH26006@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 04, 2015 at 04:16:34PM +0000, Timur Tabi wrote:
> On 02/04/2015 10:08 AM, Mark Salter wrote:
> > acpi_os_remap() is used to map ACPI tables. These tables may be in ram
> > which are already included in the kernel's linear RAM mapping. So we
> > need ioremap_cache to avoid two mappings to the same physical page
> > having different caching attributes.
> 
> Would it be possible to modify ioremap() so that it can tell whether the 
> memory is already mapped in some way, and then use a compatible remapping?

No. We have some semantics for ioremap() and it should return
non-cacheable mapping.

ioremap_cache() checks whether the page is RAM already and returns the
existing kernel linear mapping on arm64.

-- 
Catalin
