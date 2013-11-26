From: anup@brainfault.org (Anup Patel)
Date: Tue, 26 Nov 2013 09:29:55 +0530
Subject: [PATCH 1/2] KVM: Add KVM_EXIT_RESET to user space API header
In-Reply-To: <1385394599-15439-2-git-send-email-anup.patel@linaro.org>
References: <1385394599-15439-1-git-send-email-anup.patel@linaro.org>
 <1385394599-15439-2-git-send-email-anup.patel@linaro.org>
Message-ID: <CAAhSdy3yv85UknOaFJcyJd1S5YshzuqZrug8WO2ogp2UPgkp7A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Adding Christoffer, forgot to add him to CC)

On Mon, Nov 25, 2013 at 9:19 PM, Anup Patel <anup.patel@linaro.org> wrote:
> Currently, we don't have an exit reason for VM reset emulation
> in user space hence this patch adds exit reason KVM_EXIT_RESET
> for this purpose.
>
> This newly added KVM_EXIT_RESET will be used by KVM arm/arm64
> in-kernel PSCI support to reset VMs.
>
> Signed-off-by: Anup Patel <anup.patel@linaro.org>
> Signed-off-by: Pranavkumar Sawargaonkar <pranavkumar@linaro.org>
> ---
>  include/uapi/linux/kvm.h |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
> index 902f124..64a04cc 100644
> --- a/include/uapi/linux/kvm.h
> +++ b/include/uapi/linux/kvm.h
> @@ -171,6 +171,7 @@ struct kvm_pit_config {
>  #define KVM_EXIT_WATCHDOG         21
>  #define KVM_EXIT_S390_TSCH        22
>  #define KVM_EXIT_EPR              23
> +#define KVM_EXIT_RESET            24
>
>  /* For KVM_EXIT_INTERNAL_ERROR */
>  /* Emulate instruction failed. */
> --
> 1.7.9.5
>
> _______________________________________________
> kvmarm mailing list
> kvmarm at lists.cs.columbia.edu
> https://lists.cs.columbia.edu/cucslists/listinfo/kvmarm
