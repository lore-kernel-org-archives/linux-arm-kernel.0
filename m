From: will.deacon@arm.com (Will Deacon)
Date: Tue, 10 Jan 2017 17:15:00 +0000
Subject: [PATCH v4 0/9] arm64: Expose CPUID registers via emulation
In-Reply-To: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
References: <1483982912-27215-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20170110171459.GH527@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 09, 2017 at 05:28:23PM +0000, Suzuki K Poulose wrote:
> This series adds a new ABI to expose the CPU feature registers
> to the user space via emulation of MRS instruction. The system exposes
> only a limited set of feature values (See the documentation patch)
> from the cpufeature infrastructure. The feature bits that are not
> exposed are set to the 'safe value' which implies 'not supported'.
> 
> Apart from the selected feature registers, we expose MIDR_EL1 (Main
> ID Register). The user should be aware that, reading MIDR_EL1 can be
> tricky on a heterogeneous system (just like getcpu()). We export the
> value of the current CPU where 'MRS' is executed.
> 
> Applies on v4.10-rc3.

Thanks, I'll queue this for 4.11.

Will
