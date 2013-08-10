From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 10 Aug 2013 23:47:25 +0400
Subject: [PATCH] ARM: KVM: Simplify tracepoint text
In-Reply-To: <1376019686-19301-1-git-send-email-christoffer.dall@linaro.org>
References: <1376019686-19301-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <520698CD.2070904@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 08/09/2013 07:41 AM, Christoffer Dall wrote:

> The tracepoint for kvm_guest_fault was extremely long, make it a
> slightly bit shorter.

> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> ---
>   arch/arm/kvm/trace.h |    7 +++----
>   1 file changed, 3 insertions(+), 4 deletions(-)

> diff --git a/arch/arm/kvm/trace.h b/arch/arm/kvm/trace.h
> index a8e73ed..8cbaea2 100644
> --- a/arch/arm/kvm/trace.h
> +++ b/arch/arm/kvm/trace.h
> @@ -59,10 +59,9 @@ TRACE_EVENT(kvm_guest_fault,
>   		__entry->ipa			= ipa;
>   	),
>
> -	TP_printk("guest fault at PC %#08lx (hxfar %#08lx, "
> -		  "ipa %#16llx, hsr %#08lx",
> -		  __entry->vcpu_pc, __entry->hxfar,
> -		  __entry->ipa, __entry->hsr)
> +	TP_printk("ipa 0x%llx, hsr 0x%#08lx, hxfar 0x%#08lx, pc 0x%#08lx",

    "0x" and "#" are redundant, they mean the same thing, hexadecimal prefix.

WBR, Sergei
