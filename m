From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 8 Feb 2016 18:11:27 +0530
Subject: [PATCH RFC] Add cpufreq support
In-Reply-To: <45004963.Im3DmqJ5ez@wuerfel>
References: <56B4D4BE.2040008@free.fr> <2425296.hvcP5NDLXy@wuerfel>
 <20160208123111.GE8294@vireshk> <45004963.Im3DmqJ5ez@wuerfel>
Message-ID: <20160208124127.GF8294@vireshk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08-02-16, 13:34, Arnd Bergmann wrote:
> Maybe add a opp-v3 compatible string?

How will that help?

The problem was that the compatibility string of "opp-v2" specifies
the way we need to parse the bindings and shouldn't be (ab)used to
probe a driver like cpufreq-dt. And so we got stuck.

> I really don't care what you
> match on, as long we don't need any code in arch/arm/ to create a
> device we don't need.

Sure.

> Don't add the device to DT, we really don't want that.

I agree.

> If there
> is too much opposition to looking at the cpus nodes in the initcall,

I didn't get this one, what can we do by looking at CPUs nodes ?

> start with a whitelist for known machines, that at least keeps the
> existing behavior.

That can be a valid solution I would say, but that separate driver
(cpufreq-dt-device.c) needs to be changed for every new platform.

-- 
viresh
