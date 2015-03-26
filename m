From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 26 Mar 2015 17:26:32 +0000
Subject: [PATCH v5 6/6] target-arm: cpu.h document why env->spsr exists
In-Reply-To: <1427130344-27986-7-git-send-email-alex.bennee@linaro.org>
References: <1427130344-27986-1-git-send-email-alex.bennee@linaro.org>
 <1427130344-27986-7-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA_x5SGWcB1qgUKCTO+6SXVh9m1PXhHmwOzYOsVz9fK_sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2015 at 17:05, Alex Benn?e <alex.bennee@linaro.org> wrote:
> I was getting very confused about the duplication of state so wanted to
> make it explicit.
>
> Signed-off-by: Alex Benn?e <alex.bennee@linaro.org>
>
> diff --git a/target-arm/cpu.h b/target-arm/cpu.h
> index 083211c..6dc1799 100644
> --- a/target-arm/cpu.h
> +++ b/target-arm/cpu.h
> @@ -155,6 +155,11 @@ typedef struct CPUARMState {
>         This contains all the other bits.  Use cpsr_{read,write} to access
>         the whole CPSR.  */
>      uint32_t uncached_cpsr;
> +    /* The spsr is a alias for spsr_elN where N is the current
> +     * exception level.

This comment is still wrong.

> It is provided for here so the TCG msr/mrs
> +     * implementation can access one register.

...and this is wrong too.

> Care needs to be taken
> +     * to ensure the banked_spsr[] is also updated.
> +     */
>      uint32_t spsr;
>
>      /* Banked registers.  */

I think it would be better to just drop this patch, really...

-- PMM
