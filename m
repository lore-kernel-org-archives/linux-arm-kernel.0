From: gnurou@gmail.com (Alexandre Courbot)
Date: Mon, 9 Sep 2013 15:15:31 +0900
Subject: [PATCH v5 1/5] ARM: add basic Trusted Foundations support
In-Reply-To: <5228CEDB.1090306@gmail.com>
References: <1378351680-14696-1-git-send-email-acourbot@nvidia.com>
 <1378351680-14696-2-git-send-email-acourbot@nvidia.com>
 <5228CEDB.1090306@gmail.com>
Message-ID: <CAAVeFu+MGGBfmm1jwtKGP_d3EjkLdf5B_E_5RT___PVh1e=8jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 6, 2013 at 3:35 AM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/04/2013 10:27 PM, Alexandre Courbot wrote:
>> Trusted Foundations is a TrustZone-based secure monitor for ARM that
>> can be invoked  using a consistent SMC-based API on all supported
>> platforms. This patch adds initial basic support for Trusted
>> Foundations using the ARM firmware API. Current features are limited
>> to the ability to boot secondary processors.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> Reviewed-by: Tomasz Figa <t.figa@samsung.com>
>> Reviewed-by: Stephen Warren <swarren@nvidia.com>
>> ---
>>  .../arm/firmware/tl,trusted-foundations.txt        | 17 +++++
>>  .../devicetree/bindings/vendor-prefixes.txt        |  1 +
>>  arch/arm/Kconfig                                   |  2 +
>>  arch/arm/Makefile                                  |  1 +
>>  arch/arm/firmware/Kconfig                          | 25 +++++++
>>  arch/arm/firmware/Makefile                         |  1 +
>>  arch/arm/firmware/trusted_foundations.c            | 82 ++++++++++++++++++++++
>>  arch/arm/include/asm/trusted_foundations.h         | 53 ++++++++++++++
>>  8 files changed, 182 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
>>  create mode 100644 arch/arm/firmware/Kconfig
>>  create mode 100644 arch/arm/firmware/Makefile
>>  create mode 100644 arch/arm/firmware/trusted_foundations.c
>>  create mode 100644 arch/arm/include/asm/trusted_foundations.h
>>
>> diff --git a/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
>> new file mode 100644
>> index 0000000..3954bbd
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/arm/firmware/tl,trusted-foundations.txt
>> @@ -0,0 +1,17 @@
>> +Trusted Foundations
>> +
>> +Boards that use the Trusted Foundations secure monitor can signal its
>> +presence by declaring a node compatible with "tl,trusted-foundations"
>> +under the root node.
>> +
>> +Required properties:
>> +- compatible : "tl,trusted-foundations"
>> +- version-major : major version number of Trusted Foundations firmware
>> +- version-minor: minor version number of Trusted Foundations firmware
>> +
>> +Example:
>> +     firmware {
>> +             compatible = "tl,trusted-foundations";
>> +             version-major = <2>;
>> +             version-minor = <8>;
>> +     };
>
> I'm wondering how we fit this in with PSCI bindings? Both are pieces of
> firmware functionality and may co-exist. There's nothing incompatible
> here, but there should be some commonality. Will future versions of
> Trusted Foundations follow the SMC calling conventions doc? What about
> armv8 support.

I don't have any information about the future of TF unfortunately,
excepted that it should remain backward-compatible. What is this SMC
calling convention doc your are talking about btw? Is there a standard
calling convention defined by ARM?

Alex.
