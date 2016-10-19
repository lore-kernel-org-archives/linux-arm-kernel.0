From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Oct 2016 12:14:24 +0200
Subject: [PATCH 0/5] Switch to the DT cpufreq policy on the Integrator
In-Reply-To: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
References: <1476871154-32243-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <6720864.e2sjvVVhdQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, October 19, 2016 11:59:09 AM CEST Linus Walleij wrote:
> 
> If people are happy with this approach and approve of the patches
> I'd like an ACK from the cpufreq people and then merge the whole set
> through ARM SoC.
> 

I don't see any hard dependency here, so I'd suggest to merge the
two cpufreq patches through the subsystem tree, and the ARM patches
through arm-soc.

The patches look fine.

Removing the custom driver of course means that we break machines
with old .dtb files, so we could consider leaving the driver in
place, but probably there is no need for integrator.

	Arnd
