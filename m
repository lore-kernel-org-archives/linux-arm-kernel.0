From: peter.maydell@linaro.org (Peter Maydell)
Date: Tue, 17 Mar 2015 15:50:37 +0000
Subject: [PATCH v4 5/5] target-arm: cpu.h document why env->spsr exists
In-Reply-To: <1426503716-13931-6-git-send-email-alex.bennee@linaro.org>
References: <1426503716-13931-1-git-send-email-alex.bennee@linaro.org>
 <1426503716-13931-6-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA97OF2rMPNew8kiJrWBC+f=70c=G-pAC5tiYnEx6r6AYA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 March 2015 at 11:01, Alex Benn?e <alex.bennee@linaro.org> wrote:
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

I could have sworn I'd commented about this in an earlier
version. It's not an alias for spsr_elN, because on AArch32 there are
multiple SPSRs at EL1; it is the current SPSR, and
the SPSRs for other modes are stored in banked_spsr[].

    /* SPSR for current mode. */

would do IMHO (matching the comment for env->regs[].)

-- PMM
