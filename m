From: Dave.Martin@arm.com (Dave Martin)
Date: Wed, 21 Oct 2015 11:28:06 +0100
Subject: [UPDATED] [PATCHv4 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021102806.GH4801@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:24:37PM +0100, Suzuki K. Poulose wrote:
> Resending the series with fixed mail ids.
> 
> ---
> This series introduces a new infrastructure to keep track of the CPU
> feature registers on ARMv8-A for arm64 kernel. It provides the safe value
> of a CPU feature register across all the CPUs on (a heterogeneous) system.
> The infrastructure checks the individual CPU feature registers as they are
> brought online (during system boot up) and udpates the status of each of
> the feature bits across the system. Once all the active CPUs are brought
> online (i.e, smp_cpus_done() ), the system can compute a reliable set of
> capabilities (arm64_features CPU capability and ELF HWCAP). This allows
> system to operate safely on CPUs with differing capabilities. Any new CPU
> brought up(hotplugged in) should have all the established capabilities,
> failing which could be disastrous. (e.g, alternative code patched in for
> a feature avaialble on the system). We add a hotplug notifier to check if
> the new CPU is missing any of the advertised capabilities and prevents it
> from turning online if it is.

[...]

For the series,

Tested-by: Dave Martin <Dave.Martin@arm.com>

(i.e., the system boots and MRS from userspace seems to do the correct
thing -- I haven't stressed the series.)

I don't propose to review the patch content in detail since other
people have already looked at it, the the code looks reasonable and
seems to work but I'll let you know if I spot anything.

Cheers
---Dave
