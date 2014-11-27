From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Thu, 27 Nov 2014 13:29:55 +0800
Subject: [PATCH v2 2/3] ACPI / processor: Convert apic_id to phys_id to
 make it arch agnostic
In-Reply-To: <1417064853-27905-3-git-send-email-hanjun.guo@linaro.com>
References: <1417064853-27905-1-git-send-email-hanjun.guo@linaro.com>
 <1417064853-27905-3-git-send-email-hanjun.guo@linaro.com>
Message-ID: <5476B6D3.9080700@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael,

On 2014-11-27 13:07, Hanjun Guo wrote:
> apic_id in MADT table is the CPU hardware id which identify
> it self in the system for x86 and ia64, OSPM will use it for
> SMP init to map APIC ID to logical cpu number in the early
> boot, when the DSDT/SSDT (ACPI namespace) is scanned later, the
> ACPI processor driver is probed and the driver will use acpi_id
> in DSDT to get the apic_id, then map to the logical cpu number
> which is needed by the processor driver.
> 
> Before ACPI 5.0, only x86 and ia64 were supported in ACPI spec,
> so apic_id is used both in arch code and ACPI core which is
> pretty fine. Since ACPI 5.0, ARM is supported by ACPI and
> APIC is not available on ARM, this will confuse people when
> apic_id is both used by x86 and ARM in one function.
> 
> So convert apic_id to phys_id (which is the original meaning)
> in ACPI processor dirver to make it arch agnostic, but leave the
> arch dependent code unchanged, no functional change.
> 
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.com>

Sorry, my bad, not linaro.com but linaro.org, and patch 3
has the same problem, if you need resend those patch, please
let me know.

Thanks
Hanjun
