From: svenkatr@ti.com (S, Venkatraman)
Date: Thu, 3 Nov 2011 17:42:36 +0530
Subject: [PATCH] mmc: omap_hsmmc: fix typo around pr_info() call
In-Reply-To: <1320319482-9809-1-git-send-email-zonque@gmail.com>
References: <1320319482-9809-1-git-send-email-zonque@gmail.com>
Message-ID: <CANfBPZ-Z5PZFwW1uderk5A1FzNKFq=9f-RTOSg0Lre5CX-NDUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 3, 2011 at 4:54 PM, Daniel Mack <zonque@gmail.com> wrote:
> This was introduced by a3c76eb9 ("mmc: replace printk with appropriate
> display macro").
>
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> Cc: Girish K S <girish.shivananjappa@linaro.org>
> Cc: Chris Ball <cjb@laptop.org>
> ---
> ?drivers/mmc/host/omap_hsmmc.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> index e8ff123..101cd31 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -1270,7 +1270,7 @@ static void omap_hsmmc_protect_card(struct omap_hsmmc_host *host)
> ? ? ? ? ? ? ? ?}
> ? ? ? ?} else {
> ? ? ? ? ? ? ? ?if (!host->protect_card) {
> - ? ? ? ? ? ? ? ? ? ? ? pr_info"%s: cover is open, "
> + ? ? ? ? ? ? ? ? ? ? ? pr_info("%s: cover is open, "
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? "card is now inaccessible\n",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? mmc_hostname(host->mmc));
> ? ? ? ? ? ? ? ? ? ? ? ?host->protect_card = 1;
> --
> 1.7.6.4
>

Thanks ! But this has been fixed and is available in mmc-next
