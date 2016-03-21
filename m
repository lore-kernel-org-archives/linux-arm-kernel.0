From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Mon, 21 Mar 2016 10:54:44 +0100
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <20160321095049.GD27778@vireshk-i7>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego> <20160321095049.GD27778@vireshk-i7>
Message-ID: <1505152.fhSnu3pvDr@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, 21. M?rz 2016, 15:20:49 schrieb Viresh Kumar:
> On 18-03-16, 13:56, Heiko St?bner wrote:
> > Also, on both the rk3368 as well as the rk3399, you probably want the
> > cluster- handling of arm-bL-cpufreq-dt.
> > Contrary to its name it is _not_ limited to switching between clusters,
> > but
> > can also control frequencies of multiple cpu-clusters running at the same
> > time.
> 
> We aren't adding any new users to bL driver, please use cpufreq-dt as that
> also supports multiple clusters now.

I hadn't seen that yet ... nice that cpufreq-dt now also supports clusters :-)

The other part still stands though, as we probably should register the 
platform-device somewhere else and not in some new special module.

When everything is using cpufreq-dt now, I guess we could just add it to the 
core rockchip clk-code. Or was there some agreement where this should be done 
(obviously not the devicetree itself)?
