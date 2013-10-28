From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Mon, 28 Oct 2013 12:04:43 +0100
Subject: [PATCH v8 1/5] ARM: add basic support for Trusted Foundations
In-Reply-To: <525D7969.5060908@nvidia.com>
References: <1381527938-22840-1-git-send-email-acourbot@nvidia.com>
 <1381527938-22840-2-git-send-email-acourbot@nvidia.com>
 <20131015110725.GZ25034@n2100.arm.linux.org.uk>
 <525D7969.5060908@nvidia.com>
Message-ID: <CA+Ln22FdkcxOfq-yxVVQ7vTLWC3TYRBbAOZ=e3WmpSKkgk_DRg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2013/10/15 Alex Courbot <acourbot@nvidia.com>:
> On 10/15/2013 04:07 AM, Russell King - ARM Linux wrote:
>>
>> On Fri, Oct 11, 2013 at 02:45:34PM -0700, Alexandre Courbot wrote:
>>>
>>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
>>> can be invoked using the same SMC-based API on all supported
>>> platforms. This patch adds initial basic support for Trusted
>>> Foundations using the ARM firmware API. Current features are limited
>>> to the ability to boot secondary processors.
>>>
>>> Note: The API followed by Trusted Foundations does *not* follow the SMC
>>> calling conventions. It has nothing to do with PSCI neither and is only
>>> relevant to devices that use Trusted Foundations (like most Tegra-based
>>> retail devices).
>>>
>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>>> ---
>>>   .../arm/firmware/tl,trusted-foundations.txt        | 20 ++++++
>>>   .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>>   arch/arm/Kconfig                                   |  2 +
>>>   arch/arm/Makefile                                  |  1 +
>>>   arch/arm/firmware/Kconfig                          | 28 ++++++++
>>>   arch/arm/firmware/Makefile                         |  1 +
>>>   arch/arm/firmware/trusted_foundations.c            | 79
>>> ++++++++++++++++++++++
>>>   arch/arm/include/asm/trusted_foundations.h         | 68
>>> +++++++++++++++++++
>>>   8 files changed, 200 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
>>>   create mode 100644 arch/arm/firmware/Kconfig
>>>   create mode 100644 arch/arm/firmware/Makefile
>>>   create mode 100644 arch/arm/firmware/trusted_foundations.c
>>>   create mode 100644 arch/arm/include/asm/trusted_foundations.h
>>
>>
>> Is having this under arch/arm appropriate?  What happens if the API
>> gets re-used on ARM64 for example?  Would drivers/firmware be a better
>> cross-arch location for this?
>
>
> The reason why this has been put into arch/arm is that the firmware_ops
> feature this patch depends also resides there
> (arch/arm/include/asm/firmware.h).
>
> On the other hand it might also make sense to move firmware_ops out of ARM
> since I don't see anything ARM-specific with it. Tomasz, could we have your
> thoughts on this?

I don't see anything wrong in moving this out of arch/arm, feel free
to do so.

However I guess that some (or all) of the names will have to
be put into a more separate namespace, as the term "firmware" is a bit
too generic IMHO. Possibly something like platform_firmware could be
better.

What do you think?

Best regards,
Tomasz
