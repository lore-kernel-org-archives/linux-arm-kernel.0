From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Wed, 24 Aug 2016 11:19:06 +0100
Subject: [PATCH] arm64: KVM: Enable support for Cortex-A72
In-Reply-To: <57BD679A.6060406@huawei.com>
References: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
 <ffda6889-5c31-1b56-942c-de65bbb1c16f@arm.com> <57BD679A.6060406@huawei.com>
Message-ID: <c02d842a-2576-92f5-8b25-8802cd9876d4@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24/08/16 10:23, Shannon Zhao wrote:
>
>
> On 2016/8/24 16:57, Suzuki K Poulose wrote:
>> On 24/08/16 08:21, Shannon Zhao wrote:
>>> In order to allow KVM to run on Cortex-A72 physical cpus, enable KVM
>>> support for Cortex-A72.
>>
>> Do we really need this change ? Given that A72 is using the generic_v8
>> table,
>> it will automatically be supported via the GENERIC_V8 target. That was
>> added
>> just for this purpose. The pre-existing targets were preserved so that
>> we don't break the ABI for older user space.
>>
> Yes, this works for qemu with "-cpu host". But if it specifies the cpu
> type with "-cpu cortex-a72". It will fail without this patch.

Thats because you specify the expected target from the kernel in Qemu.

I don't know what are the plans for Qemu. Are we going to add every single
ARM CPU released to the target list both in Kernel and Qemu ? e.g, what about
A35, A73 and others from the partners ?

Suzuki

>
> The corresponding qemu patches could be found at [1].
> [1] https://lists.gnu.org/archive/html/qemu-devel/2016-08/msg03653.html
>
> Thanks,
>
