From: mka@chromium.org (Matthias Kaehlcke)
Date: Wed, 29 Aug 2018 11:12:16 -0700
Subject: [PATCH v1] arm64: dts: sdm845: enable tsens thermal zones
In-Reply-To: <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
References: <cover.1531899325.git.amit.kucheria@linaro.org>
 <b3c25cedfa3a9b8a4b481e714992afe62b84ca3b.1531899325.git.amit.kucheria@linaro.org>
 <f416d38c-b91f-f58e-8cde-d4ad09a0a726@linaro.org>
Message-ID: <20180829181216.GD10879@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 11:39:12AM +0200, Daniel Lezcano wrote:
> On 18/07/2018 09:49, Amit Kucheria wrote:
> > One thermal zone per cpu is defined
> 
> The thermal zones are very close, especially when the CPUs belong to the
> same 'cluster'. Very likely the temperature will propagate from one core
> to another core, so when one core reaches the trip0, there is good
> chance the other cores will be close and cross the trip0 threshold too.
> 
> Having multiple thermal zones, one per CPU, may trigger an interrupts
> storm with the passive polling timer delay.
> 
> Does this board have a cooling device per CPU also ?

The cpufreq driver is still under development:
https://lore.kernel.org/patchwork/patch/966833/ . It currently doesn't
register cooling devices, but since CPUs from a 'cluster' use the same
cpufreq policy I think there will be one cooling device per 'cluster'.
