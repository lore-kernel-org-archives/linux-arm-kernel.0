From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 20 Apr 2011 21:48:19 +0800
Subject: [PATCH] pxa/magician: bq24022 regulator needs to be enabled
In-Reply-To: <1303306891.2703.3.camel@flow>
References: <E1QAkBF-0003bF-A0@outmx04.plus.net>
	<20110419084032.GA30743@rainbow> <20110419113201.GA32248@rainbow>
	<BANLkTim_=pwuOvkRfMz_ZQe=NtJfGijajA@mail.gmail.com>
	<1303306891.2703.3.camel@flow>
Message-ID: <BANLkTim33CVj7YRatMSYC5dbzPr+QQgvCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 9:41 PM, Philipp Zabel <philipp.zabel@gmail.com> wrote:
> Add REGULATOR_CHANGE_STATUS flag to magician bq24022 regulator to enable charging.
>
> Signed-off-by: Philipp Zabel <philipp.zabel@gmail.com>

Applied to 'fix'. Thanks.

> ---
> ?arch/arm/mach-pxa/magician.c | ? ?2 +-
> ?1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
> index a72993d..9984ef7 100644
> --- a/arch/arm/mach-pxa/magician.c
> +++ b/arch/arm/mach-pxa/magician.c
> @@ -599,7 +599,7 @@ static struct regulator_consumer_supply bq24022_consumers[] = {
> ?static struct regulator_init_data bq24022_init_data = {
> ? ? ? ?.constraints = {
> ? ? ? ? ? ? ? ?.max_uA ? ? ? ? = 500000,
> - ? ? ? ? ? ? ? .valid_ops_mask = REGULATOR_CHANGE_CURRENT,
> + ? ? ? ? ? ? ? .valid_ops_mask = REGULATOR_CHANGE_CURRENT | REGULATOR_CHANGE_STATUS,
> ? ? ? ?},
> ? ? ? ?.num_consumer_supplies ?= ARRAY_SIZE(bq24022_consumers),
> ? ? ? ?.consumer_supplies ? ? ?= bq24022_consumers,
> --
> 1.7.4.4
>
>
>
