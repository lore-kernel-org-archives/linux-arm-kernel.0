From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 4 Jan 2018 17:05:16 +0000
Subject: [PATCH 08/11] arm64: KVM: Use per-CPU vector when BP hardening is
 enabled
In-Reply-To: <060b7c34-bce9-da78-f9cb-2e67dd2ee142@arm.com>
References: <1515078515-13723-1-git-send-email-will.deacon@arm.com>
 <1515078515-13723-9-git-send-email-will.deacon@arm.com>
 <CAKv+Gu_wNtjh57PW0jyr39iswiqRMR=5wFezGhgcM4uyv_yuww@mail.gmail.com>
 <060b7c34-bce9-da78-f9cb-2e67dd2ee142@arm.com>
Message-ID: <CAKv+Gu80RoCdCMpzxsO-1KDvNWdoKysVcZpbrxzawNFFaQ5+3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 January 2018 at 17:04, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 04/01/18 16:28, Ard Biesheuvel wrote:
>> On 4 January 2018 at 15:08, Will Deacon <will.deacon@arm.com> wrote:
>>> From: Marc Zyngier <marc.zyngier@arm.com>
>>>
>>> Now that we have per-CPU vectors, let's plug then in the KVM/arm64 code.
>>>
>>
>> Why does bp hardening require per-cpu vectors?
>
> The description is not 100% accurate. We have per *CPU type* vectors.
> This stems from the following, slightly conflicting requirements:
>
> - We have systems with more than one CPU type (think big-little)
> - Different implementations require different BP hardening sequences
> - The BP hardening sequence must be executed before doing any branch
>
> The natural solution is to have one set of vectors per CPU type,
> containing the BP hardening sequence for that particular implementation,
> ending with a branch to the common code.
>

Crystal clear, thanks.
