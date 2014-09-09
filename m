From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 02:14:58 -0400
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <5404AE56.80801@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <5404AE56.80801@arm.com>
Message-ID: <540E9AE2.5070902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/01/2014 01:35 PM, Marc Zyngier wrote:
> On 01/09/14 15:57, Hanjun Guo wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> ACPI kernel uses MADT table for proper GIC initialization. It needs to
>> parse GIC related subtables, collect CPU interface and distributor
>> addresses and call driver initialization function (which is hardware
>> abstraction agnostic). In a similar way, FDT initialize GICv1/2.
>>
>> NOTE: This commit allow to initialize GICv1/2 only.
> 
> I cannot help but notice that there is no support for KVM here. It'd be
> good to add a note to that effect, so that people do not expect
> virtualization support to be working when booting with ACPI.

Wei Huang within Red Hat is currently beginning the process of bringing
up KVM support under ACPI on real hardware. This will be fixed asap.

Jon.
