From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Tue, 22 Aug 2017 15:25:06 +0200
Subject: [PATCH 2/3 v3] mfd: db8500-prcmu: Get rid of cpufreq dependency
In-Reply-To: <20170822131741.23473-2-linus.walleij@linaro.org>
References: <20170822131741.23473-1-linus.walleij@linaro.org>
 <20170822131741.23473-2-linus.walleij@linaro.org>
Message-ID: <7661350.vR4F4a82RE@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, August 22, 2017 3:17:40 PM CEST Linus Walleij wrote:
> The ARMSS clock, also known as the operating point of the
> CPU, should not cross-depend on cpufreq like this. Move
> the code to use just frequencies and remove the false
> frequency (1GHz) and put in the actual frequency provided
> by the ARMSS clock (998400000 Hz) as part of the process.
> 
> After this and the related cpufreq patch, the DB8500 will
> simply use the standard DT cpufreq driver to change the
> operating points through the common clock framework using
> the ARMSS clock.
> 
> Acked-by: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Well, I've already applied the v2, so do you want me to replace the
commit with this patch?

Thanks,
Rafael
