From: jcm@redhat.com (Jon Masters)
Date: Tue, 09 Sep 2014 02:21:20 -0400
Subject: [PATCH v3 13/17] ARM64 / ACPI: Add GICv2 specific ACPI boot
 support
In-Reply-To: <5406EDDC.3020208@arm.com>
References: <1409583475-6978-1-git-send-email-hanjun.guo@linaro.org>
 <1409583475-6978-14-git-send-email-hanjun.guo@linaro.org>
 <5404AE56.80801@arm.com> <5405AE95.1020201@linaro.org>
 <5405BFE7.5060005@arm.com> <5405E626.4090306@linaro.org>
 <5406EDDC.3020208@arm.com>
Message-ID: <540E9C60.4090103@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2014 06:30 AM, Marc Zyngier wrote:
> On 02/09/14 16:45, Hanjun Guo wrote:

>> This value is for max processors entries in MADT, and we will use it to scan MADT
>> for SMP/GIC Init, I just make it big enough for GICv3/4. since ACPI core will stop
>> scan MADT if the real numbers of processors entries are reached no matter
>> how big ACPI_MAX_GICV3_CPU_INTERFACE_ENTRIES is, I think we can just
>> define a number big enough then it will work (x86 and ia64 did the same thing).
> 
> Also, with GICv3++, there is no such thing as a memory-mapped CPU
> interface anymore. What you get is a bunch of redistributors (one per
> CPU). I assume what you have here actually describe the redistributors,
> and its name should reflect that.

(though you could have a GICv3/v4 system providing a legacy GICv2(m)
compatibility mode having the CPU memory interfaces still defined)

Jon.
