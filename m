From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Thu, 14 Apr 2016 18:47:46 +0100
Subject: [PATCH 1/5] arm64: cpufeature: Add scope for capability check
In-Reply-To: <20160414173809.GN4584@arm.com>
References: <1459941854-5190-1-git-send-email-suzuki.poulose@arm.com>
 <1459941854-5190-2-git-send-email-suzuki.poulose@arm.com>
 <20160414173809.GN4584@arm.com>
Message-ID: <570FD7C2.9030305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/04/16 18:38, Will Deacon wrote:
> Hi Suzuki,
>
> On Wed, Apr 06, 2016 at 12:24:10PM +0100, Suzuki K Poulose wrote:
>> Add scope parameter to the arm64_cpu_capabilities::matches(),
>> so that this can be reused for checking the capability on a
>> given CPU vs the system wide. By default, the system uses
>> 'system' wide values for setting the CPU_HWCAPs and ELF_HWCAPs.

>>   static bool __maybe_unused
>> -is_affected_midr_range(const struct arm64_cpu_capabilities *entry)
>> +is_affected_midr_range(const struct arm64_cpu_capabilities *entry, int __unused)
>
> Maybe it would be better to WARN if somebody passes SCOPE_SYSTEM, rather
> than silently treat it as per-cpu?

Should we worry about errata's which may not necessarily depend on per CPU or
a local capability (GIC) ? If not, we could add a WARN after passing down LOCAL
scope for errata. Right now we always do SCOPE_SYSTEM from update_cpu_capabilities(), even for
cpu_errata table. There is no specific reason for that.

Cheers
Suzuki




>
> Will
>
