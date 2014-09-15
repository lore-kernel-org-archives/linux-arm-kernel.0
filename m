From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 15:56:31 +0100
Subject: [PATCH v4 11/18] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <54134DB4.6010705@redhat.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
 <54134DB4.6010705@redhat.com>
Message-ID: <20140915145630.GE5415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 12, 2014 at 08:47:00PM +0100, Jon Masters wrote:
> On 09/12/2014 10:00 AM, Hanjun Guo wrote:
> > MADT contains the information for MPIDR which is essential for
> > SMP initialization, parse the GIC cpu interface structures to
> > get the MPIDR value and map it to cpu_logical_map(), and add
> > enabled cpu with valid MPIDR into cpu_possible_map.
> > 
> > ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
> > Parking protocol, but the Parking protocol is only specified for
> > ARMv7 now, so make PSCI as the only way for the SMP boot protocol
> > before some updates for the ACPI spec or the Parking protocol spec.
> 
> As an aside, initial support for the Parking Protocol is working on test
> systems within Red Hat at this time.

BTW, have the details of the parking protocol been updated for ARMv8
yet?

-- 
Catalin
