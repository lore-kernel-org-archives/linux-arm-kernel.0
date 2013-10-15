From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 15 Oct 2013 10:11:59 -0600
Subject: [PATCH v8 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <20131015110725.GZ25034@n2100.arm.linux.org.uk>
References: <1381527938-22840-1-git-send-email-acourbot@nvidia.com>
 <1381527938-22840-2-git-send-email-acourbot@nvidia.com>
 <20131015110725.GZ25034@n2100.arm.linux.org.uk>
Message-ID: <525D694F.3070803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2013 05:07 AM, Russell King - ARM Linux wrote:
> On Fri, Oct 11, 2013 at 02:45:34PM -0700, Alexandre Courbot wrote:
>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
>> can be invoked using the same SMC-based API on all supported
>> platforms. This patch adds initial basic support for Trusted
>> Foundations using the ARM firmware API. Current features are limited
>> to the ability to boot secondary processors.
>>
>> Note: The API followed by Trusted Foundations does *not* follow the SMC
>> calling conventions. It has nothing to do with PSCI neither and is only
>> relevant to devices that use Trusted Foundations (like most Tegra-based
>> retail devices).
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  .../arm/firmware/tl,trusted-foundations.txt        | 20 ++++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>  arch/arm/Kconfig                                   |  2 +
>>  arch/arm/Makefile                                  |  1 +
>>  arch/arm/firmware/Kconfig                          | 28 ++++++++
>>  arch/arm/firmware/Makefile                         |  1 +
>>  arch/arm/firmware/trusted_foundations.c            | 79 ++++++++++++++++++++++
>>  arch/arm/include/asm/trusted_foundations.h         | 68 +++++++++++++++++++
>>  8 files changed, 200 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
>>  create mode 100644 arch/arm/firmware/Kconfig
>>  create mode 100644 arch/arm/firmware/Makefile
>>  create mode 100644 arch/arm/firmware/trusted_foundations.c
>>  create mode 100644 arch/arm/include/asm/trusted_foundations.h
> 
> Is having this under arch/arm appropriate?  What happens if the API
> gets re-used on ARM64 for example?  Would drivers/firmware be a better
> cross-arch location for this?

That's probably a better location, yes.

BTW, drivers/firmware/ doesn't seem to have an overall maintainer. Who
should Alex send the patch to, or should I just take this patch throught
the Tegra tree once the files are moved?
