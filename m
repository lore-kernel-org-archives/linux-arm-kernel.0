From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 7 Mar 2017 06:58:21 -0800
Subject: [PATCH V3 1/4] KVM: Add documentation for KVM_CAP_NR_MEMSLOTS
In-Reply-To: <1488865964-17346-2-git-send-email-linucherian@gmail.com>
References: <1488865964-17346-1-git-send-email-linucherian@gmail.com>
 <1488865964-17346-2-git-send-email-linucherian@gmail.com>
Message-ID: <20170307145821.GE101711@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 07, 2017 at 11:22:41AM +0530, linucherian at gmail.com wrote:
> From: Linu Cherian <linu.cherian@cavium.com>

Please add a patch description, even if it just repeats the subject line
as in this case.

Otherwise:

Acked-by: Christoffer Dall <cdall@linaro.org>

> 
> Signed-off-by: Linu Cherian <linu.cherian@cavium.com>
> ---
>  Documentation/virtual/kvm/api.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
> index 03145b7..7b82f1c 100644
> --- a/Documentation/virtual/kvm/api.txt
> +++ b/Documentation/virtual/kvm/api.txt
> @@ -951,6 +951,10 @@ This ioctl allows the user to create or modify a guest physical memory
>  slot.  When changing an existing slot, it may be moved in the guest
>  physical memory space, or its flags may be modified.  It may not be
>  resized.  Slots may not overlap in guest physical address space.
> +Bits 0-15 of "slot" specifies the slot id and this value should be
> +less than the maximum number of user memory slots supported per VM.
> +The maximum allowed slots can be queried using KVM_CAP_NR_MEMSLOTS,
> +if this capability is supported by the architecture.
>  
>  If KVM_CAP_MULTI_ADDRESS_SPACE is available, bits 16-31 of "slot"
>  specifies the address space which is being modified.  They must be
> -- 
> 1.9.1
> 
