From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Oct 2015 10:28:59 +0100
Subject: [UPDATED] [PATCHv4 00/24] arm64: Consolidate CPU feature handling
In-Reply-To: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
References: <1445261101-22344-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20151021092859.GO11226@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 02:24:37PM +0100, Suzuki K. Poulose wrote:
> At the end( Patches 19-24 ) , we add a new ABI to expose the CPU feature
> registers to the user space via emulation of MRS. The system exposes only a
> limited set of feature values (See the documentation patch) from the above
> infrastructure. The feature bits that are not exposed are set to the 'safe
> value' which implies 'not supported'.
> 
> Apart from the selected feature registers, we expose MIDR_EL1 (Main
> ID Register). The user should be aware that, reading MIDR_EL1 can be
> tricky on a heterogeneous system (just like getcpu()). We export the
> value of the current CPU where 'MRS' is executed. REVIDR is not exposed
> via MRS, since we cannot guarantee atomic access to both MIDR and REVIDR
> (task migration). So they both are exposed via sysfs under :
> 
> 	/sys/devices/system/cpu/cpu$ID/identification/
> 							\- midr
> 							\- revidr
> 
> The ABI useful for the toolchains (e.g, gcc, dynamic linker, JIT) to make
> better runtime decisions based on what is available.

I queued patches 1-18 (I haven't pushed them out yet as I've seen Dave
sending some comments) and plan to merge them in 4.4. Patches 19-24 need
wider review and input from user space folk (dynamic loader, JDK) on
whether the ABI is right for them before we commit to maintaining it in
the kernel.

Thanks.

-- 
Catalin
