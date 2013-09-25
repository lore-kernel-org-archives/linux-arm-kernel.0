From: anup@brainfault.org (Anup Patel)
Date: Wed, 25 Sep 2013 17:58:07 +0530
Subject: [PATCH v4 4/4] KVM: Add documentation for KVM_ARM_PREFERRED_TARGET
 ioctl
In-Reply-To: <ECFE274D-FC43-43AD-8A9E-D3131E327F26@suse.de>
References: <1380101163-20028-1-git-send-email-anup.patel@linaro.org>
 <1380101163-20028-5-git-send-email-anup.patel@linaro.org>
 <ECFE274D-FC43-43AD-8A9E-D3131E327F26@suse.de>
Message-ID: <CAAhSdy1hZc3Cx51KLwEaDUo4fbiLLzdcBJYXrFgv5AxdWDzbMg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 25, 2013 at 5:43 PM, Alexander Graf <agraf@suse.de> wrote:
>
> On 25.09.2013, at 11:26, Anup Patel wrote:
>
>> To implement CPU=Host we have added KVM_ARM_PREFERRED_TARGET
>> vm ioctl which provides information to user space required for
>> creating VCPU matching underlying Host.
>>
>> This patch adds info related to this new KVM_ARM_PREFERRED_TARGET
>> vm ioctl in the KVM API documentation.
>>
>> Signed-off-by: Anup Patel <anup.patel@linaro.org>
>> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
>> ---
>> Documentation/virtual/kvm/api.txt |   27 +++++++++++++++++++++++----
>> 1 file changed, 23 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
>> index 858aecf..f31e6e8 100644
>> --- a/Documentation/virtual/kvm/api.txt
>> +++ b/Documentation/virtual/kvm/api.txt
>> @@ -2303,8 +2303,28 @@ Possible features:
>>       - KVM_ARM_VCPU_EL1_32BIT: Starts the CPU in a 32bit mode.
>>         Depends on KVM_CAP_ARM_EL1_32BIT (arm64 only).
>>
>> +4.83 KVM_ARM_PREFERRED_TARGET
>
> Why 4.83 and not 4.86? It feels backwards to rename all these other sections.

I wanted to have KVM_ARM_xxxx IOCTLs located nearby hence
placed KVM_ARM_PREFERRED_TARGET after KVM_ARM_VCPU_INIT.

There is no point in keeping KVM_ARM_PREFERRED_TARGET
after KVM_PPC_RTAS_DEFINE_TOKEN and make
KVM_PPC_RTAS_DEFINE_TOKEN dangle in-between documentation
of various KVM_ARM_xxxx IOCTLs.

>
>
> Alex
>
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm

--Anup
