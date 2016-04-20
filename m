From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 20 Apr 2016 18:33:54 +0100
Subject: [RFC PATCH] arm64: KVM: Allow userspace to configure guest
 MPIDR_EL1
In-Reply-To: <1461161319-38835-1-git-send-email-ashoks@broadcom.com>
References: <1461161319-38835-1-git-send-email-ashoks@broadcom.com>
Message-ID: <20160420183354.31f1bfbd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 20 Apr 2016 07:08:39 -0700
Ashok Kumar <ashoks@broadcom.com> wrote:

> For guests with NUMA configuration, Node ID needs to
> be recorded in the respective affinity byte of MPIDR_EL1.

As others have said before, the mapping between the NUMA hierarchy and
MPIDR_EL1 are completely arbitrary, and only the firmware description
can help the kernel in interpreting the affinity levels.

If you want any patch like this one to be considered, I'd like to see
the corresponding userspace that:

- programs the affinity into the vcpus,
- pins the vcpus to specific physical CPUs,
- exposes the corresponding firmware description (either DT or ACPI) to
  the kernel.

Short of having all these elements together, there is little point in
letting userspace messing with the guest's affinity registers.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
