From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 29 Jun 2017 17:15:19 +0200
Subject: [GIT PULL] ARM: actions: arm for v4.13
In-Reply-To: <20170623172556.12618-1-afaerber@suse.de>
References: <20170623172556.12618-1-afaerber@suse.de>
Message-ID: <CAK8P3a1Kg8620=vt68jagoSHDsCQ29ZABVFnkiRCxnWLCNZUhw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 23, 2017 at 7:25 PM, Andreas F?rber <afaerber@suse.de> wrote:
> Hi Arnd and Olof,
>
> Here's the initial arm pull for Actions Semi.
>
> Regards,
> Andreas
>
> The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:
>
>   Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)
>
> are available in the git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git tags/actions-arm-soc-for-4.13
>
> for you to fetch changes up to ba2694def2361d9b8d944f6df4aa077ad7290746:
>
>   MAINTAINERS: Update Actions Semi section with SPS (2017-06-21 18:17:44 +0200)
>
> ----------------------------------------------------------------
> Actions Semi ARM SoC for v4.13
>
> This adds a Kconfig symbol and mach-actions with board and SMP code,
> plus a MAINTAINERS entry.
>
> ----------------------------------------------------------------
> Andreas F?rber (4):
>       ARM: Prepare Actions Semi S500
>       MAINTAINERS: Add Actions Semi Owl section
>       ARM: owl: Implement CPU enable-method for S500
>       MAINTAINERS: Update Actions Semi section with SPS
>
>  MAINTAINERS                     |  16 ++++
>  arch/arm/Kconfig                |   2 +
>  arch/arm/Makefile               |   1 +
>  arch/arm/mach-actions/Kconfig   |  15 ++++
>  arch/arm/mach-actions/Makefile  |   4 +
>  arch/arm/mach-actions/headsmp.S |  68 ++++++++++++++++
>  arch/arm/mach-actions/owl.c     |  28 +++++++
>  arch/arm/mach-actions/platsmp.c | 166 ++++++++++++++++++++++++++++++++++++++++

Pulled into next/soc now. Please note that I had one review comment
on the pen_release() logic, which I think can be omitted here as you have
hardware support for wakeup_secondary.

If you can remove it completely, that would be perfect, otherwise we still have
an issue with the __cpuc_flush_dcache_area(), which should probably be
sync_cache_w() instead.

I've applied the patches this time, as there is no regression potential for
the new code, and I should really have caught this earlier in the review,
but please follow up with a modification as a bugfix for 4.13.

       Arnd
