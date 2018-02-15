From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 15 Feb 2018 21:28:28 +0000
Subject: [PATCH v4 00/17] arm64: Add SMCCC v1.1 support and CVE-2017-5715
 (Spectre variant 2) mitigation
In-Reply-To: <e9df17e7-86ee-2f7a-b8e2-d78ac0358fc3@redhat.com>
References: <20180206175621.929-1-marc.zyngier@arm.com>
 <e9df17e7-86ee-2f7a-b8e2-d78ac0358fc3@redhat.com>
Message-ID: <86fu6254eb.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 20:59:29 +0000,
Jon Masters wrote:
> 
> Hi Marc, all,
> 
> On 02/06/2018 12:56 PM, Marc Zyngier wrote:
> > ARM has recently published a SMC Calling Convention (SMCCC)
> > specification update[1] that provides an optimised calling convention
> > and optional, discoverable support for mitigating CVE-2017-5715. ARM
> > Trusted Firmware (ATF) has already gained such an implementation[2].
> 
> I'm probably just missing something, but does this end up reported
> somewhere conveniently user visible? In particular, if the new SMC is
> *not* provided, does the user end up easily seeing this?

What exactly do you want to make visible to userspace?

If you want the SMC implementation of the CVE workaround to be
reported, it wouldn't be very useful, as the SMC instruction is not
available at EL0. It also only covers part of the mitigation spectrum
(we have cores that implement the mitigation using different
mechanisms).

If what you're after is a userspace visible indication of a mitigation
for this CVE (by whatever method available), then this is still a work
in progress, and relies on this series[1] so that we can properly
handle systems containing a combination of affected and non-affected
CPUs. The plan is to expose the status as part of the sysfs interface,
? la x86 and covering all 3 known vulnerabilities.

Thanks,

	M.

[1] https://lkml.org/lkml/2018/2/9/579

-- 
Jazz is not dead, it just smell funny.
