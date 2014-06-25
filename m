From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 25 Jun 2014 09:36:40 +0200
Subject: [PATCH] Exynos4: cpuidle: support dual CPUs with AFTR state
In-Reply-To: <539B7E74.7000605@linaro.org>
References: <1396604925-18383-1-git-send-email-daniel.lezcano@linaro.org>
 <1402476643.32147.6.camel@AMDC1943> <539B7E74.7000605@linaro.org>
Message-ID: <1403681800.19087.8.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On sob, 2014-06-14 at 00:43 +0200, Daniel Lezcano wrote:
> On 06/11/2014 10:50 AM, Krzysztof Kozlowski wrote:
(...)
> >
> > Hi,
> >
> > Shouldn't the exynos_idle_barrier be initialized here?
> 
> As it is a static data it will be initialized to zero.
> 
> > I know you sent the patch almost 2 months ago but I stomped on this
> > while testing it on Exynos3250.
> 
> No problem. And what results on exynos3250 ?

I had to change some of the ways for synchronization two cores (boot
vector behaves differently) so actually the driver is different except
the general idea. As for the results (on dual-core Exynos3250) - the
mode (AFTR+CPU1 off) consumes about 5% less energy than idle-WFI state.

I expect there will be much more savings in deeper mode (called here
W-AFTR).

Best regards,
Krzysztof
