From: peter.maydell@linaro.org (Peter Maydell)
Date: Wed, 11 Mar 2015 15:47:44 +0000
Subject: [PATCH 6/6] target-arm/cpu.h: document why env->spsr exists
In-Reply-To: <1424880159-29348-8-git-send-email-alex.bennee@linaro.org>
References: <1424880159-29348-1-git-send-email-alex.bennee@linaro.org>
 <1424880159-29348-8-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8jRtdCtxCE5KLNCBLi7CgEb3=qSUVU--HPu=QTt5wadw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25 February 2015 at 16:02, Alex Benn?e <alex.bennee@linaro.org> wrote:
> I was getting very confused about the duplication of state. Perhaps we
> should just get rid of env->spsr and use helpers that understand the
> banking?

I've already disagreed with this. I would suggest putting
tentative questions about future direction of the codebase
below the '---' rather than in the commit log :-)


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
> +     * exception level.

This isn't true for AArch32 (which has multiple different SPSRs
any of which might be the one in env->spsr when we're at EL1).

-- PMM
