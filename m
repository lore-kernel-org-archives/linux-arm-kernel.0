From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 18 May 2015 18:33:29 +0100
Subject: [PATCHv2 06/12] arm64: psci: account for Trusted OS instances
In-Reply-To: <1431945503-6939-7-git-send-email-mark.rutland@arm.com>
References: <1431945503-6939-1-git-send-email-mark.rutland@arm.com>
 <1431945503-6939-7-git-send-email-mark.rutland@arm.com>
Message-ID: <20150518173329.GM21251@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 18, 2015 at 11:38:17AM +0100, Mark Rutland wrote:
> Software resident in the secure world (a "Trusted OS") may cause CPU_OFF
> calls for the CPU it is resident on to be denied. Such a denial would be
> fatal for the kernel, and so we must detect when this can happen before
> the point of no return.
> 
> This patch implements Trusted OS detection for PSCI 0.2+ systems, using
> MIGRATE_INFO_TYPE and MIGRATE_INFO_UP_CPU. When a trusted OS is detected
> as resident on a particular CPU, attempts to hot unplug that CPU will be
> denied early, before they can prove fatal.
> 
> Trusted OS migration is not implemented by this patch. Implementation of
> migratable UP trusted OSs seems unlikely, and the right policy for
> migration is unclear (and will likely differ across implementations). As
> such, it is likely that migration will require cooperation with Trusted
> OS drivers.
> 
> PSCI implementations prior to 0.1 do not provide the facility to detect
> the presence of a Trusted OS, nor the CPU any such OS is resident on, so
> without additional information it is not possible to handle Trusted OSs
> with PSCI 0.1.
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
