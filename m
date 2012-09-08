From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 08 Sep 2012 14:48:35 +0530
Subject: [PATCH v3 00/31] AArch64 Linux kernel port
In-Reply-To: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
References: <1347035226-18649-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <504B0D6B.9010908@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin,

On Friday 07 September 2012 09:56 PM, Catalin Marinas wrote:
> This is the 3rd version of patches implementing Linux kernel support for
> the 64-bit ARM architecture. Most of the review comments for the
> previous release have been implemented. There are a few left (like
> generic timer dts specification) but the main goal was to freeze the
> user ABI.
>
> The Linux kernel patches are available on this tree:
>
Firstly thanks for clarifying the questions asked on the previous
version and also for the update on the arch timer code.

Mostly I was looking at the series from SOC boot and CPU PM
point of view and boot part seems to just fine.

As per discussion at LPC, I have gone through the SMC
proposal which ARM has published. In general the boot part
with SMC seems to be doable and can be standardized across SOCs.
The part which will be conflicting is the CPU power management.
That seems to be the harder one and the document is at too
infancy stage from the details point of view. Some bits about
save, restore are related to switcher kind of architecture, which
may not be the requirement for all the SoCs.

Ofcourse the SMC discussion is not related to $subject series
as such. Also the PM support for ARMv8 not seems be the scope
of the series so the discussion can be parked aside till we
need to talk about it. I have few more questions on the various
MM attribute usage, exceptions and PL's but I will do some
reading before asking those to you.

For the series itself, feel free to add my ack if yo
need one.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
