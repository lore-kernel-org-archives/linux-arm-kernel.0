From: gengdongjiu@huawei.com (gengdongjiu)
Date: Tue, 28 Mar 2017 12:19:43 +0800
Subject: [PATCH V13 10/10] arm/arm64: KVM: add guest SEA support
In-Reply-To: <20170324160158.GH25903@cbox>
References: <1490136425-4324-1-git-send-email-tbaicar@codeaurora.org>
 <1490136425-4324-11-git-send-email-tbaicar@codeaurora.org>
 <20170324160158.GH25903@cbox>
Message-ID: <734ab018-2112-eddf-10dc-426f8ebe3848@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tyler,

I have a question for below code.

On 2017/3/25 0:01, Christoffer Dall wrote:
>  	is_iabt = kvm_vcpu_trap_is_iabt(vcpu);
> -	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu))) {
> +	if (unlikely(!is_iabt && kvm_vcpu_dabt_isextabt(vcpu)) && sea_status) {
>  		kvm_inject_vabt(vcpu);
when it is SEA synchronized abort, why here inject a asynchronous abort through kvm_inject_vabt(vcpu) instead of synchronized abort? seem the original kvm source code is also do that, so I am confused about that.
thanks .

>  		return 1;
>  	}
