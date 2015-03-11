From: greg.bellows@linaro.org (Greg Bellows)
Date: Wed, 11 Mar 2015 10:39:47 -0500
Subject: [Qemu-devel] [PATCH 6/6] target-arm/cpu.h: document why env->spsr
 exists
In-Reply-To: <1424880159-29348-8-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-8-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAOgzsHWzroog_K3DAXtS=UzP_s9488LT=Q54FykN3yuC+xOvqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 25, 2015 at 10:02 AM, Alex Benn?e <alex.bennee@linaro.org> wrote:
> I was getting very confused about the duplication of state. Perhaps we
> should just get rid of env->spsr and use helpers that understand the
> banking?
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index 11845a6..d7fd13f 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -155,6 +155,11 @@ typedef struct CPUARMState {
>         This contains all the other bits.  Use cpsr_{read,write} to access
>         the whole CPSR.  */
>      uint32_t uncached_cpsr;
> +    /* The spsr is a alias for spsr_elN where N is the current

"an alias"

> +     * exception level. It is provided for here so the TCG msr/mrs

remove "for here"

> +     * implementation can access one register. Care needs to be taken
> +     * to ensure the banked_spsr[] is also updated.
> +     */
>      uint32_t spsr;
>
>      /* Banked registers.  */
> --
> 2.3.0
>
>

Otherwise...

Reviewed-by: Greg Bellows <greg.bellows@linaro.org>
