From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 7 Apr 2017 14:09:45 -0500
Subject: [PATCHv2 15/16] arm64: pmuv3: handle !PMUv3 when probing
In-Reply-To: <20170407180507.GA5783@leverpostej>
References: <1491503363-17731-1-git-send-email-mark.rutland@arm.com>
 <1491503363-17731-16-git-send-email-mark.rutland@arm.com>
 <20170407142908.GO19342@arm.com> <20170407180507.GA5783@leverpostej>
Message-ID: <1e55376b-3c38-354c-6ba2-f607f0cc9709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2017 01:05 PM, Mark Rutland wrote:
> On Fri, Apr 07, 2017 at 03:29:09PM +0100, Will Deacon wrote:
>> On Thu, Apr 06, 2017 at 07:29:22PM +0100, Mark Rutland wrote:
>>> When probing via ACPI, we won't know up-front whether a CPU has a PMUv3
>>> compatible PMU. Thus we need to consult ID registers during probe time.
>>>
>>> This patch updates our PMUv3 probing code to test for the presence of
>>> PMUv3 functionality before touching an PMUv3-specific registers, and
>>> before updating the struct arm_pmu with PMUv3 data.
>
> [...]
>
>> It would also be worth spinning this up on qemu, if you get a chance, as
>> I don't think that implements the PMU.
>
> That raises the usual problem with GSIs in static ACPI tables; the MADT
> GICC doesn't have any way of describing the absense of a PMU interrupt.
>
> Booting a TCG qemu, the PMU GSI is zero, which is a valid GSI...
>
> There's a spec bug to fix here.

Or a QEMU bug... The SBSA mandates a PMU AFAIK. So you won't have an 
ACPI system without one.


>
> Urrgh.
>
> Thanks,
> Mark.
>
