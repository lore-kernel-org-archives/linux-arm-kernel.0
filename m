From: dron0gus@gmail.com (Dron Gus)
Date: Fri, 30 Dec 2011 10:48:30 +0300
Subject: [RFC] cpufreq: Add S3C2416/S3C2450 cpufreq driver
In-Reply-To: <201112292058.07448.heiko@sntech.de>
References: <201112292058.07448.heiko@sntech.de>
Message-ID: <CAA11ShBk=HFt6qaZex+VK=DfZtTvrf9bhyLKW0Gk2g_E5D44PA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi.

On Thu, Dec 29, 2011 at 11:58 PM, Heiko St?bner <heiko@sntech.de> wrote:
...
> +static int __init s3c2416_cpufreq_driver_init(struct cpufreq_policy *policy)
...
> + ? ? ? s3c_freq->armdiv = clk_get(NULL, "armdiv");
> + ? ? ? if (IS_ERR(s3c_freq->armdiv)) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Unable to obtain ARMDIV: %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ?PTR_ERR(s3c_freq->armdiv));
> + ? ? ? ? ? ? ? return PTR_ERR(s3c_freq->armdiv);
> + ? ? ? }
> +
> + ? ? ? s3c_freq->hclk = clk_get(NULL, "hclk");
> + ? ? ? if (IS_ERR(s3c_freq->hclk)) {
> + ? ? ? ? ? ? ? pr_warn("cpufreq: Unable to obtain HCLK: %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ?PTR_ERR(s3c_freq->hclk));
> + ? ? ? ? ? ? ? s3c_freq->hclk = NULL; /*we can live without hclk */
> + ? ? ? }
clk_put allready obtained "armdiv"?

> +
> + ? ? ? s3c_freq->armclk = clk_get(NULL, "armclk");
> + ? ? ? if (IS_ERR(s3c_freq->armclk)) {
> + ? ? ? ? ? ? ? pr_err("cpufreq: Unable to obtain ARMCLK: %ld\n",
> + ? ? ? ? ? ? ? ? ? ? ?PTR_ERR(s3c_freq->armclk));
> + ? ? ? ? ? ? ? return PTR_ERR(s3c_freq->armclk);
> + ? ? ? }
Same for "hclk" and "armclk"?
