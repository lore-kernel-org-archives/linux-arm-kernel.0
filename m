From: jcm@redhat.com (Jon Masters)
Date: Mon, 15 Sep 2014 19:19:49 -0400
Subject: [PATCH v4 11/18] ARM64 / ACPI: Parse MADT for SMP initialization
In-Reply-To: <20140915145630.GE5415@arm.com>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-12-git-send-email-hanjun.guo@linaro.org>
 <54134DB4.6010705@redhat.com> <20140915145630.GE5415@arm.com>
Message-ID: <54177415.6070306@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2014 10:56 AM, Catalin Marinas wrote:
> On Fri, Sep 12, 2014 at 08:47:00PM +0100, Jon Masters wrote:
>> On 09/12/2014 10:00 AM, Hanjun Guo wrote:
>>> MADT contains the information for MPIDR which is essential for
>>> SMP initialization, parse the GIC cpu interface structures to
>>> get the MPIDR value and map it to cpu_logical_map(), and add
>>> enabled cpu with valid MPIDR into cpu_possible_map.
>>>
>>> ACPI 5.1 only has two explicit methods to boot up SMP, PSCI and
>>> Parking protocol, but the Parking protocol is only specified for
>>> ARMv7 now, so make PSCI as the only way for the SMP boot protocol
>>> before some updates for the ACPI spec or the Parking protocol spec.
>>
>> As an aside, initial support for the Parking Protocol is working on test
>> systems within Red Hat at this time.
> 
> BTW, have the details of the parking protocol been updated for ARMv8
> yet?

There's an interim specification for which initial (test, in
development) patches are currently in the fedorahosted development
kernel. Mark is planning to followup on that once he's had chance to
polish and clean things up. But the parking protocol is not required for
initial ACPI enablement (we really want everyone to be doing PSCI
anyway, it's only a small subset that will ever do parking protocol).

Jon.
