From: dave.martin@linaro.org (Dave Martin)
Date: Mon, 18 Jul 2011 11:32:37 +0100
Subject: [PATCH] freshen up mm/proc-arm946.S
In-Reply-To: <5A630F46702DD1498FFD48394B4A664CB39A93520F@john.ad.clarku.edu>
References: <5A630F46702DD1498FFD48394B4A664CB39A93520F@john.ad.clarku.edu>
Message-ID: <CA+wbFdeYFQP6GC2zzPW4EPdG82UECT8Fo1FxxHfYq0Rp2tu7qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi there,

On Fri, Jul 15, 2011 at 11:12 PM, Brian Julin <BJulin@clarku.edu> wrote:
>
> This patch helps get ?things compiling/working when ARM946 is selected. ?It fixes a
> missing structure member and a typo in mm/proc-arm946.S
>
> Signed-off-by: Brian S. Julin <bri@abrij.org>
> --- a/arch/arm/mm/proc-arm946.S 2011-07-14 15:00:27.000000000 -0400
> +++ b/arch/arm/mm/proc-arm946.S 2011-07-10 14:27:13.000000000 -0400
> @@ -450,4 +450,5 @@
> ? ? ? ?.long ? 0xff00fff0
> ? ? ? ?.long ? 0
> + ? ? ? .long ? 0
> ? ? ? ?b ? ? ? __arm946_setup
> ? ? ? ?.long ? cpu_arch_name
> @@ -458,5 +459,5 @@
> ? ? ? ?.long ? 0
> ? ? ? ?.long ? 0
> - ? ? ? .long ? arm940_cache_fns
> + ? ? ? .long ? arm946_cache_fns
> ? ? ? ?.size ? __arm946_proc_info, . - __arm946_proc_info

If you've not already done so, I suggest you check that your patch
applies against Russell's devel-stable branch.  There has been a bit
of refactoring of some of these files, but I think your patch will
stlil apply (unfortunately I'm not in a position to test it right
now).

The patch looks at least possibly correct (I'm not able to check that
either, today...)

http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur devel-stable

Cheers
---Dave
