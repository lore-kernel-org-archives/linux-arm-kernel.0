From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Fri, 2 Sep 2016 17:07:06 +0100
Subject: [PATCH 2/2] arm64: Use static keys for CPU features
In-Reply-To: <20160902155224.GC391@e104818-lin.cambridge.arm.com>
References: <1472145992-10660-1-git-send-email-catalin.marinas@arm.com>
 <1472145992-10660-3-git-send-email-catalin.marinas@arm.com>
 <f690f532-a05e-5c13-6b97-b94203701d3d@arm.com>
 <20160902155224.GC391@e104818-lin.cambridge.arm.com>
Message-ID: <827c65c6-9690-5805-8769-1159634a3c77@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/09/16 16:52, Catalin Marinas wrote:
> On Fri, Aug 26, 2016 at 10:22:13AM +0100, Suzuki K. Poulose wrote:
>> On 25/08/16 18:26, Catalin Marinas wrote:

>>
>> Just a heads up. I have a patch [1] which moves the "check_local_cpu_errata()"
>> around to smp_prepare_boot_cpu(). This patch should still work fine with that
>> case. Only that may be we could move the jump_lable_init() to smp_prepare_boot_cpu(),
>> before we call "update_cpu_errata_work_arounds()" for Boot CPU.
>
> IIUC, we wouldn't call update_cpu_errata_work_arounds() until the CPU
> feature infrastructure is initialised via cpuinfo_store_boot_cpu(). So
> I don't think moving the jump_label_init() call above is necessary.

Right, as I said, your patch should work fine even with that change. Its just that,
jump_label_init() (a generic kernel setup) can be called from a better visible
place (smp_prepare_boot_cpu()) than from a less interesting place with the patch
below.

Cheers
Suzuki


>
>> [1] https://lkml.kernel.org/r/1471525832-21209-4-git-send-email-suzuki.poulose at arm.com
>
