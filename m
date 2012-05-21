From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Mon, 21 May 2012 11:34:21 +0530
Subject: [PATCH v2] RFC: ARM: cache-l2x0: update workaround for PL310
 errata 727915
In-Reply-To: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
References: <1337546505-24660-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <CAMQu2gy3VTtQhnVVvzgYGhr_vA=vnW=rSBW17yoBTNwkN3wHqQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 21, 2012 at 2:11 AM, Linus Walleij
<linus.walleij@stericsson.com> wrote:
> From: Colin Cross <ccross@android.com>
>
> ARM errata 727915 for PL310 has been updated to include a new
> workaround required for PL310 r2p0 for l2x0_flush_all, which also
> affects l2x0_clean_all in my testing. For r2p0, clean or flush
> each set/way individually. For r3p0 or greater, use the debug
> register for cleaning and flushing.
>
> Requires exporting the cache_id, sets and ways detected in the
> init function for later use.
>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Per Fransson <per.fransson.ml@gmail.com>
> Signed-off-by: Colin Cross <ccross@android.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> I found this thing in the Android tree, it looks like it could
> be pretty serious so I'm mailing it out. If it is correct I
> guess it should even be tagged for -stable?
>
> v2: what about actually git commit --amend in the rebase changes
> for -rc7? Sorry for the screwup...
> ---
This was observed on OMAP4460 devices. Though the errata
document doesn't support it, the issue seen with l2 clean was
indeed fixed $subject fix.

Regards
Santosh
