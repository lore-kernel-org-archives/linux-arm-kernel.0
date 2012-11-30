From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 30 Nov 2012 13:04:29 +0100
Subject: [PATCH 0/5] cpufreq: db8500: Rename driver and update some parts
In-Reply-To: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
References: <1354098464-6665-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <CAPDyKFr9hLkzg6VMsZSr_0bafJydL__Q-=3cf6Mx5d8ry3Zbiw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 November 2012 11:27, Ulf Hansson <ulf.hansson@stericsson.com> wrote:
> From: Ulf Hansson <ulf.hansson@linaro.org>
>
> This patchset starts by renaming the db8500 cpufreq driver to a more generic
> name. There are new variants which rely on it too, so instead we give it a
> family name of dbx500.
>
> On top of that a fixup patch for initialization of the driver and some minor
> cleanup patches are included as well.
>
> These patches can be material for 3.8, thus I think it should be fine if the
> patches are merged through different trees. Unless some of the maintainers
> are of other opinions.
>
> Jonas Aaberg (1):
>   cpufreq: dbx500: Minor code cleanup
>
> Lee Jones (3):
>   cpufreq: Give driver used for dbx500 family a more generic name
>   mfd: db8500: Update cpufreq device name
>   cpufreq: dbx500: Update file header
>
> Ulf Hansson (1):
>   cpufreq: dbx500: Move clk_get to probe
>
>  drivers/cpufreq/Makefile         |    2 +-
>  drivers/cpufreq/db8500-cpufreq.c |  179 -------------------------------------
>  drivers/cpufreq/dbx500-cpufreq.c |  180 ++++++++++++++++++++++++++++++++++++++
>  drivers/mfd/db8500-prcmu.c       |    4 +-
>  4 files changed, 183 insertions(+), 182 deletions(-)
>  delete mode 100644 drivers/cpufreq/db8500-cpufreq.c
>  create mode 100644 drivers/cpufreq/dbx500-cpufreq.c
>
> --
> 1.7.10
>

Thanks to Samuel I realized that of course these patches would need to
go through Mike Turquette's clock tree. They are applying there.
This since we have merged clock patches which had dependencies to both
mfd and cpufreq.

Thus I will instead try to collect acks as a way forward.

Mike, please tell me if you are not happy with this setup or if you
would like me to resend.

Kind regards
Ulf Hansson
