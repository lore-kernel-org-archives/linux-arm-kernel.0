From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 05 Dec 2013 06:14:47 -0300
Subject: [PATCH] ARM: Clean up setup printks a bit
In-Reply-To: <1386199826-8183-1-git-send-email-olof@lixom.net>
References: <1386199826-8183-1-git-send-email-olof@lixom.net>
Message-ID: <52A04407.4000306@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof,

El 04/12/13 20:30, Olof Johansson escribi?:
> Clean up the setup ARM printks a bit. Add printk level to a few
> that were missing (CPU: <...> ones, in particular), and switch from
> printk(KERN_* ..) to pr_*().
>
> Finally, un-wrap some long lines since it makes it harder to grep the
> sources from where an error came from and tweak some cases of indentation.
>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>   arch/arm/kernel/setup.c |   39 +++++++++++++++++++--------------------
>   1 file changed, 19 insertions(+), 20 deletions(-)
>
> diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> index 6a1b8a8..7c472f4 100644
> --- a/arch/arm/kernel/setup.c
> +++ b/arch/arm/kernel/setup.c

...

>
>   	if (meminfo.nr_banks >= NR_BANKS) {
> -		printk(KERN_CRIT "NR_BANKS too low, "
> -			"ignoring memory at 0x%08llx\n", (long long)start);
> +		pr_crit("NR_BANKS too low, "ignoring memory at 0x%08llx\n",

There's a stray " there

> +			(long long)start);
>   		return -EINVAL;
>   	}
>

Cheers,

Emilio
