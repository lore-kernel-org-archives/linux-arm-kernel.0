From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 30 Sep 2013 09:47:04 -0700
Subject: [PATCH 0/3] nohz full: drop 64-bit requirement,
 enable ARM support v2
In-Reply-To: <1380550012-7321-1-git-send-email-fweisbec@gmail.com> (Frederic
 Weisbecker's message of "Mon, 30 Sep 2013 16:06:49 +0200")
References: <1380550012-7321-1-git-send-email-fweisbec@gmail.com>
Message-ID: <87li2ejlyv.fsf@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Frederic Weisbecker <fweisbec@gmail.com> writes:

> Hi Kevin,
>
> Your patchset was fine but I just did a second round. Namely I did the following changes:
>
> * Drop the 64 bits dependency after we settle the new dependency on HAVE_VIRT_CPU_ACCOUNTING_GEN
> and not before. This way we don't have a middle state that loose the dependency in the middle of
> the patchset. Probablyt no big deal but it looks more natural this way.
>
> * Refined a few changelogs.
>
> If you're ok I'll send a pull request to Ingo.

Looks good to me, thanks.

Kevin

> Kevin Hilman (3):
>   vtime: Add HAVE_VIRT_CPU_ACCOUNTING_GEN Kconfig
>   nohz: Drop generic vtime obsolete dependency on CONFIG_64BIT
>   ARM: Kconfig: allow full nohz CPU accounting
>
>  arch/Kconfig        | 12 ++++++++++++
>  arch/arm/Kconfig    |  1 +
>  init/Kconfig        |  3 ++-
>  kernel/time/Kconfig |  2 +-
>  4 files changed, 16 insertions(+), 2 deletions(-)
