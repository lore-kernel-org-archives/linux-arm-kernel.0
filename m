From: peter.maydell@linaro.org (Peter Maydell)
Date: Thu, 26 Mar 2015 17:20:34 +0000
Subject: [PATCH v5 4/6] target-arm: kvm64 sync FP register state
In-Reply-To: <1427130344-27986-5-git-send-email-alex.bennee@linaro.org>
References: <1427130344-27986-1-git-send-email-alex.bennee@linaro.org>
 <1427130344-27986-5-git-send-email-alex.bennee@linaro.org>
Message-ID: <CAFEAcA8i8tptcox=PhUHqSWhBaSu0RyoeFKQoT_GvH_6A5oHcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23 March 2015 at 17:05, Alex Benn?e <alex.bennee@linaro.org> wrote:
> +    /* Advanced SIMD and FP registers
> +     * We map Qn = regs[2n+1]:regs[2n]
> +     */
> +    for (i = 0; i < 32; i++) {
> +        int rd = i << 1;
> +        float128 fp_val = make_float128(env->vfp.regs[rd + 1],
> +                                        env->vfp.regs[rd]);

float128 is part of softfloat; it doesn't really belong here...

-- PMM
