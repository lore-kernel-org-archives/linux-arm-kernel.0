From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Aug 2016 10:57:57 +0200
Subject: [PATCH] ARM: cpuidle: declare cpuidle_ops __read_mostly
In-Reply-To: <1470818997-808-1-git-send-email-jszhang@marvell.com>
References: <1470818997-808-1-git-send-email-jszhang@marvell.com>
Message-ID: <2118361.tr3K3hSZxF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, August 10, 2016 4:49:57 PM CEST Jisheng Zhang wrote:
> diff --git a/arch/arm/kernel/cpuidle.c b/arch/arm/kernel/cpuidle.c
> index 7dccc96..762e0929 100644
> --- a/arch/arm/kernel/cpuidle.c
> +++ b/arch/arm/kernel/cpuidle.c
> @@ -19,7 +19,7 @@ extern struct of_cpuidle_method __cpuidle_method_of_table[];
>  static const struct of_cpuidle_method __cpuidle_method_of_table_sentinel
>         __used __section(__cpuidle_method_of_table_end);
>  
> -static struct cpuidle_ops cpuidle_ops[NR_CPUS];
> +static struct cpuidle_ops cpuidle_ops[NR_CPUS] __read_mostly;

Should this perhaps be percpu data instead?

	Arnd
