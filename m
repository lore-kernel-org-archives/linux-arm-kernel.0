From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 29 Jan 2015 11:32:49 +0100
Subject: [PATCH 0/8] PM / Domains: Re-structure code for adding/removing
 devices to genpd
In-Reply-To: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
References: <1422389625-11730-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <CAMuHMdWOEYX8S_j80ay4KepESHSJVFFW5UD=cKo_cMQ=Ak0U8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 27, 2015 at 9:13 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> While adding error handling of genpd's ->attach_dev() callback, I realized that
> we also had a need to re-structure some of the code which deals with
> adding/removing devices to genpd. Especially the APIs, __pm_genpd_add_device()
> and pm_genpd_remove_device() deserved some attention.
>
> Patch 1 -> 4, can be considered as more simple cleanups and should not impact
> the behavior for current clients using the APIs.
>
> Patch 5, eliminates a mutex for generic_pm_domain_data by re-order the
> initialization/cleanup of dev_pm_qos notifiers.
>
> Patch 6, move some code around to fix a potenial memory leakage of a struct
> pm_subsys_data.
>
> Patch 7, code restructuring which impacts locking behavior while adding/removing
> devices. Should improve code readability and decrease critical regions of
> holding locks.
>
> Patch 8, Adds error handling of genpd's ->attach_dev() callback
>
>
> Ulf Hansson (8):
>   PM / Domains: Rename __pm_genpd_alloc|free_dev_data()
>   PM / Domains: Remove reference counting for the generic_pm_domain_data
>   PM / Domains: Don't allow an existing generic_pm_domain_data
>   PM / Domains: Don't check for an existing device when adding a new
>   PM / Domains: Eliminate the mutex for the generic_pm_domain_data
>   PM / Domains: Free pm_subsys_data in error path in
>     __pm_genpd_add_device()
>   PM / Domains: Re-order initialization of generic_pm_domain_data
>   PM / Domains: Handle errors from genpd's ->attach_dev() callback

Looks OK, and tested on sh73a0/kzm9g-multiplatform with PM domains
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
