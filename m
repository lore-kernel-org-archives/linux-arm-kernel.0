From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 24 Aug 2016 11:54:50 +0100
Subject: [PATCH] arm64: KVM: Enable support for Cortex-A72
In-Reply-To: <c02d842a-2576-92f5-8b25-8802cd9876d4@arm.com>
References: <1472023297-2756-1-git-send-email-zhaoshenglong@huawei.com>
 <ffda6889-5c31-1b56-942c-de65bbb1c16f@arm.com> <57BD679A.6060406@huawei.com>
 <c02d842a-2576-92f5-8b25-8802cd9876d4@arm.com>
Message-ID: <CAFEAcA_6=7ko_w=8MNC3nB2GTw2o=zZkCvZoLx5N0iO5Z65L_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 August 2016 at 11:19, Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:
> On 24/08/16 10:23, Shannon Zhao wrote:
>> Yes, this works for qemu with "-cpu host". But if it specifies the cpu
>> type with "-cpu cortex-a72". It will fail without this patch.
>
>
> Thats because you specify the expected target from the kernel in Qemu.

That's because if the user said "I really really want a cortex-A72 in
the guest" then we need to tell the kernel "really must be an A72"
(and the kernel can then fake it up in some hypothetical future world
where we can simulate A72 on non-A72 h/w). If the user is happy
with "whatever the kernel's best effort is" that's what -cpu host does.
If there's no way to tell the kernel "must be an A72" we fail the command
because we can't do what the user asked for.

thanks
-- PMM
