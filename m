From: mgherzan@gmail.com (Mircea Gherzan)
Date: Mon, 11 Mar 2013 17:54:43 +0100
Subject: [PATCH] ARM:net: an issue for k which is u32, never < 0
In-Reply-To: <513BECDA.3030803@asianux.com>
References: <513BECDA.3030803@asianux.com>
Message-ID: <CAN9tCgRw9RKRVosMAKqqYTvkEmEXEqjGm3Sp0ajE+ibd+V9a_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2013/3/10 Chen Gang <gang.chen@asianux.com>:
>
>   k is u32 which never < 0, need type cast, or cause issue.
>
> Signed-off-by: Chen Gang <gang.chen@asianux.com>
> ---
>  arch/arm/net/bpf_jit_32.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
> index 6828ef6..a0bd8a7 100644
> --- a/arch/arm/net/bpf_jit_32.c
> +++ b/arch/arm/net/bpf_jit_32.c
> @@ -576,7 +576,7 @@ load_ind:
>                         /* x = ((*(frame + k)) & 0xf) << 2; */
>                         ctx->seen |= SEEN_X | SEEN_DATA | SEEN_CALL;
>                         /* the interpreter should deal with the negative K */
> -                       if (k < 0)
> +                       if ((int)k < 0)
>                                 return -1;
>                         /* offset in r1: we might have to take the slow path */
>                         emit_mov_i(r_off, k, ctx);
> --
> 1.7.7.6

Acked-by: Mircea Gherzan <mgherzan@gmail.com>
