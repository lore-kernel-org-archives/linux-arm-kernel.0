From: Suzuki.Poulose@arm.com (Suzuki K. Poulose)
Date: Wed, 30 Sep 2015 17:13:55 +0100
Subject: [PATCH 16/22] arm64/debug: Make use of the system wide safe value
In-Reply-To: <560A8159.8000300@arm.com>
References: <1442413280-31885-1-git-send-email-suzuki.poulose@arm.com>
 <1442413280-31885-17-git-send-email-suzuki.poulose@arm.com>
 <560A8159.8000300@arm.com>
Message-ID: <560C0A43.1040209@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/09/15 13:17, Vladimir Murzin wrote:
> On 16/09/15 15:21, Suzuki K. Poulose wrote:
>> From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>
>>
>> Use the system wide value of ID_AA64DFR0 to make safer decisions
>>
>> Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
>> ---
>>   arch/arm64/include/asm/hw_breakpoint.h |   14 ++------------
>>   arch/arm64/kernel/debug-monitors.c     |    6 ++++--
>>   arch/arm64/kernel/hw_breakpoint.c      |   19 ++++++++++++++++++-
>>   3 files changed, 24 insertions(+), 15 deletions(-)
>>
>
> Looks like this patch introduces build-time regression if
> CONFIG_PERF_EVENTS is not set:
>
>> arch/arm64/kvm/built-in.o: In function `kvm_arm_setup_debug':
>> /work/tools/linux/arch/arm64/kvm/debug.c:173: undefined reference to `get_num_brps'
>> /work/tools/linux/arch/arm64/kvm/debug.c:177: undefined reference to `get_num_wrps'
>> arch/arm64/kvm/built-in.o: In function `kvm_arm_clear_debug':
>> /work/tools/linux/arch/arm64/kvm/debug.c:208: undefined reference to `get_num_brps'
>> /work/tools/linux/arch/arm64/kvm/debug.c:212: undefined reference to `get_num_wrps'
>> arch/arm64/kvm/built-in.o: In function `kvm_arch_dev_ioctl_check_extension':
>> /work/tools/linux/arch/arm64/kvm/reset.c:78: undefined reference to `get_num_wrps'
>> /work/tools/linux/arch/arm64/kvm/reset.c:75: undefined reference to `get_num_brps'
>> make: *** [vmlinux] Error 1

The fixed series is available here :

git://linux-arm.org/linux-skp.git cpu-ftr/v1.1-4.3-rc3


I will wait for some more comments/review before I sent the updated
version to the list.

Thanks
Suzuki
