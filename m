From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 19 Jul 2018 10:10:23 +0100
Subject: [PATCH v8 2/4] arm64: KVM: export the capability to set guest
 SError syndrome
In-Reply-To: <86da7b47-5026-5ec7-96dc-4d3a14caa2f8@huawei.com>
References: <20180713154751.18131-1-james.morse@arm.com>
 <20180713154751.18131-3-james.morse@arm.com>
 <CAFEAcA9pK7W=gSZXTOTxFEFDmc6kJ8GDYO4a6r_P1FHp+KuT9A@mail.gmail.com>
 <86da7b47-5026-5ec7-96dc-4d3a14caa2f8@huawei.com>
Message-ID: <CAFEAcA_Amw6Pr+DmeZXHDWKQPSYf_826hDDwna2fwQvOP1+9og@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 July 2018 at 09:54, gengdongjiu <gengdongjiu@huawei.com> wrote:
> Hi peter,
>   Thanks for the review.
>
> On 2018/7/18 0:36, Peter Maydell wrote:
>> How does this capability interact with the KVM_CAP_VCPU_EVENTS
>> API in patch 1? Is it saying "you can specify the ESR via
>> that API", or talking about something else?
>
> The user space will firstly check the  KVM_CAP_VCPU_EVENTS through kvm_has_vcpu_events() to know whether KVM can support get/set vcpu events,
> If KVM supports get/set vcpu events, it will check KVM_CAP_ARM_SET_SERROR_ESR to know whether can set guest SError ESR, as shown the user space code in [1].

OK, so this capability affects the behaviour of
KVM_SET_VCPU_EVENTS. Can you make sure the documentation
of KVM_SET_VCPU_EVENTS clearly explains what happens
and the effect of whether this capability is present,
please? People trying to understand the behaviour of
that ioctl are not going to know that they need to
look here as well.

thanks
-- PMM
