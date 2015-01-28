From: elder@linaro.org (Alex Elder)
Date: Wed, 28 Jan 2015 14:15:06 -0600
Subject: [PATCH] bcm: address clang inline asm incompatibility
In-Reply-To: <CAKv+Gu8B7G3tNahkguDBjCOQih4_ywRtwaJz2D2b+vY1249-DA@mail.gmail.com>
References: <1422422306-27473-1-git-send-email-behanw@converseincode.com>	<CAKv+Gu_NCgMmX_LQqi7vtjtP4ofrW+kx8FPgRd4-LWwK=73-xg@mail.gmail.com>	<54C8EE04.6060809@linaro.org>	<CAKv+Gu8CrMqwqBOF8rYa3RP1=gfCthwP=1k9kQ73v6+Sxwah4A@mail.gmail.com>	<54C91791.9030508@linaro.org>	<CAKv+Gu8P8eC+bmerCpbSX=USODqE=U7WnLeiCfhHJ8SSVAzPDw@mail.gmail.com>	<CAKv+Gu9fc_F1iC5NAwaG_ed3RRhYnxEBLbuLgW0Oa_qJ96j-gA@mail.gmail.com>	<54C9383D.10901@linaro.org>	<CAKv+Gu88G2QqAupD9j4_-t2=0VJGNbWkUViLBM2nUuyuN-PHWA@mail.gmail.com>
 <CAKv+Gu8B7G3tNahkguDBjCOQih4_ywRtwaJz2D2b+vY1249-DA@mail.gmail.com>
Message-ID: <54C9434A.30000@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/28/2015 02:11 PM, Ard Biesheuvel wrote:
> Actually, if clang is guaranteed to emit the correct register name
> inside the inline asm for register asm variables used in input or
> output constraints, I think it makes sense to #define __asmeq as a nop
> if __clang__ is defined. (Note that __asmeq only exists to work around
> a specific GCC bug)

I agree completely.  Behan, what do you think?	-Alex
