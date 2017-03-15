From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Mar 2017 14:37:44 +0100
Subject: [PATCH] cpufreq: dbx500: Manage cooling device from cpufreq driver
In-Reply-To: <99cc71f22d0470cb164b0fa05e07a863265bf922.1489468688.git.viresh.kumar@linaro.org>
References: <99cc71f22d0470cb164b0fa05e07a863265bf922.1489468688.git.viresh.kumar@linaro.org>
Message-ID: <CACRpkdbj6UH+ZJfCYD1DKQ=3Qa=Aho9M5EWyQG8mRg=GCDEmXA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 14, 2017 at 6:18 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The best place to register the CPU cooling device is from the cpufreq
> driver as we would know if all the resources are already available or
> not. That's what is done for the cpufreq-dt.c driver as well.
>
> The cpu-cooling driver for dbx500 platform was just (un)registering
> with the thermal framework and that can be handled easily by the cpufreq
> driver as well and in proper sequence as well.
>
> Get rid of the cooling driver and its its users and manage everything
> from the cpufreq driver instead.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Only compile tested.

Works fine. Nice cleanup, thanks!
Tested-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
