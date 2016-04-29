From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 29 Apr 2016 09:42:55 +0200
Subject: [PATCH v2 07/10] gpio: stmpe: rework registers access
In-Reply-To: <1461845589-4826-8-git-send-email-patrice.chotard@st.com>
References: <1461845589-4826-1-git-send-email-patrice.chotard@st.com>
 <1461845589-4826-8-git-send-email-patrice.chotard@st.com>
Message-ID: <CACRpkdZ8NsXCaRgVCVKKiuGoCEWvAUx81Do5XangEq3Fptj3ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 28, 2016 at 2:13 PM,  <patrice.chotard@st.com> wrote:

> From: Patrice Chotard <patrice.chotard@st.com>
>
> This update allows to use registers map as following :
> regs[reg_index + offset] instead of
> regs[reg_index] + offset
>
> This makes code clearer and will facilitate the addition of STMPE1600
> on which LSB and MSB registers are respectively located at addr and addr + 1.
> Despite for all others STMPE variant, LSB and MSB registers are respectively
> located in reverse order at addr + 1 and addr.
>
> For variant which have 3 registers's bank, we use LSB,CSB and MSB indexes
> which contains respectively LSB (or LOW), CSB (or MID) and MSB (or HIGH)
> register addresses (STMPE1801/STMPE24xx).
> For variant which have 2 registers's bank, we use LSB and CSB indexes only.
> In this case the CSB index contains the MSB regs address (STMPE 1601).
>
> Signed-off-by: Patrice Chotard <patrice.chotard@st.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
