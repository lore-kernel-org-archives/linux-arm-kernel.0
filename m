From: james.morse@arm.com (James Morse)
Date: Fri, 29 Jun 2018 16:58:44 +0100
Subject: [PATCH v5 2/2] arm64: KVM: export the capability to set guest
 SError syndrome
In-Reply-To: <1529960309-2513-3-git-send-email-gengdongjiu@huawei.com>
References: <1529960309-2513-1-git-send-email-gengdongjiu@huawei.com>
 <1529960309-2513-3-git-send-email-gengdongjiu@huawei.com>
Message-ID: <bca12032-c465-1d10-f7d4-71fc044ac695@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

This patch doesn't apply on v4.18-rc2.

Documentation/virtual/kvm/api.txt already has a 8.18 section. I guess you based
this on v4.17.

For posting patches, please use the latest 'rc' from Linus' tree, (or the
maintainer's tree listed in MAINTAINERS for the tree you are targeting if the
maintainer has started to pick up patches).


Thanks,

James


On 25/06/18 21:58, Dongjiu Geng wrote:
> For the arm64 RAS Extension, user space can inject a virtual-SError
> with specified ESR. So user space needs to know whether KVM support
> to inject such SError, this interface adds this query for this capability.
> 
> KVM will check whether system support RAS Extension, if supported, KVM
> returns true to user space, otherwise returns false.


> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 3732097..86b3808 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -4628,3 +4628,14 @@ Architectures: s390
>  This capability indicates that kvm will implement the interfaces to handle
>  reset, migration and nested KVM for branch prediction blocking. The stfle
>  facility 82 should not be provided to the guest without this capability.
> +
> +8.14 KVM_CAP_ARM_SET_SERROR_ESR
> +
> +Architectures: arm, arm64
> +
> +This capability indicates that userspace can specify the syndrome value reported
> +to the guest OS when guest takes a virtual SError interrupt exception.
> +If KVM has this capability, userspace can only specify the ISS field for the ESR
> +syndrome, it can not specify the EC field which is not under control by KVM.
> +If this virtual SError is taken to EL1 using AArch64, this value will be reported
> +in ISS filed of ESR_EL1.
