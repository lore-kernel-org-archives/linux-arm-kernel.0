From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 Mar 2016 09:50:43 +0100
Subject: [PATCH 8/8] drivers/pinctrl: clean up samsung modular vs.
 non-modular distinctions
In-Reply-To: <1456778924-20730-9-git-send-email-paul.gortmaker@windriver.com>
References: <1456778924-20730-1-git-send-email-paul.gortmaker@windriver.com>
 <1456778924-20730-9-git-send-email-paul.gortmaker@windriver.com>
Message-ID: <CACRpkdYN_qRUa_hscDma_jRAF=2K7_qaGM+f5DNr-NyA3g_NHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 29, 2016 at 9:48 PM, Paul Gortmaker
<paul.gortmaker@windriver.com> wrote:

> Fixups here tend to be more all over the map vs. some of the other
> repeated/systematic ones we've seen elsewhere.
>
> We remove module.h from code that isn't doing anything modular at
> all;  if they have __init sections, then replace it with init.h
>
> A couple drivers have module_exit() code that is essentially orphaned,
> and so we remove that.
>
> There are no module_init replacements, so we have no concerns wrt.
> initcall ordering changes as per some of the other cleanups.
>
> Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.
>
> We also delete the MODULE_LICENSE tag etc. since all that information
> was (or is now) contained at the top of the file in the comments.
>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-samsung-soc at vger.kernel.org
> Cc: linux-gpio at vger.kernel.org
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

This didn't make it in for v4.6 because noone provided ACKs.

Please resend the outstanding (rebased) demodularization patches
after v4.6-rc1 and I will merge them no matter if I get ACKs or not,
I will not wait for ACKs any longer than that.

Yours,
Linus Walleij
