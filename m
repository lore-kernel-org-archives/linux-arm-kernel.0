From: drjones@redhat.com (Andrew Jones)
Date: Wed, 26 Nov 2014 15:20:40 +0100
Subject: [PATCH 1/7] KVM: add commentary for kvm_debug_exit_arch struct
In-Reply-To: <1416931805-23223-2-git-send-email-alex.bennee@linaro.org>
References: <1416931805-23223-1-git-send-email-alex.bennee@linaro.org>
 <1416931805-23223-2-git-send-email-alex.bennee@linaro.org>
Message-ID: <20141126142040.GA3245@hawk.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 25, 2014 at 04:09:59PM +0000, Alex Benn?e wrote:
> Bring into line with the commentary for the other structures and their
> KVM_EXIT_* cases.
> 
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
> 
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 6076882..523f476 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -226,6 +226,7 @@ struct kvm_run {
>  			__u32 count;
>  			__u64 data_offset; /* relative to kvm_run start */
>  		} io;
> +		/* KVM_EXIT_DEBUG */
>  		struct {
>  			struct kvm_debug_exit_arch arch;
>  		} debug;
> -- 
> 2.1.3

Can we change this to a 'KVM: add commentary for kvm exit type data'
patch? We're also missing

/* KVM_EXIT_INTERNAL_ERROR */

and

/* KVM_EXIT_PAPR_HCALL */

> 
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
