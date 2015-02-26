From: pbonzini@redhat.com (Paolo Bonzini)
Date: Thu, 26 Feb 2015 13:57:52 +0100
Subject: [PATCH 1/6] target-arm: kvm: save/restore mp state
In-Reply-To: <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-2-git-send-email-alex.bennee@linaro.org>
Message-ID: <54EF1850.5050002@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 25/02/2015 17:02, Alex Benn?e wrote:
> +#if defined CONFIG_KVM
> +        {
> +            .name = "mp_state",
> +            .version_id = 0,
> +            .size = sizeof(uint32_t),
> +            .info = &vmstate_mpstate,
> +            .flags = VMS_SINGLE,
> +            .offset = 0,
> +        },
> +#endif

This makes TCG migration state incompatible depending on whether QEMU
was built on ARM or x86.

You can instead add a subsection, and mark it as needed only iff
kvm_enabled().

Paolo

>          {
>              .name = "cpsr",
