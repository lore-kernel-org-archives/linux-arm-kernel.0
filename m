From: jcm@redhat.com (Jon Masters)
Date: Fri, 12 Sep 2014 15:47:00 -0400
Subject: [PATCH v4 11/18] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
Message-ID: <54134DB4.6010705@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> MADT contains the information for MPIDR which is essential for
> SMP initialization, parse the GIC cpu interface structures to
> get the MPIDR value and map it to cpu_logical_map(), and add
> enabled cpu with valid MPIDR into cpu_possible_map.
> 
> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> Parking protocol, but the Parking protocol is only specified for
> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> before some updates for the ACPI spec or the Parking protocol spec.

As an aside, initial support for the Parking Protocol is working on test
systems within Red Hat at this time. Additional patches for that will be
posted separately, however Parking Protocol is not the preferred option
on ARMv8 (PSCI should be the default). Consequently, support for those
limited number of systems doing Parking Protocol can follow after the
initial support for longer term PSCI is enabled.

Jon.
