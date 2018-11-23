From: horms@verge.net.au (Simon Horman)
Date: Fri, 23 Nov 2018 13:51:32 +0100
Subject: [PATCH 08/10] ARM64: dts: renesas: Add all CPUs in cooling maps
In-Reply-To: <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
References: <cover.1542362530.git.viresh.kumar@linaro.org>
 <f2116377ab65e4b3ece39c32f54ac3eec2fb7d8c.1542362530.git.viresh.kumar@linaro.org>
Message-ID: <20181123125131.fxrslxz4wvphpe5o@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2018 at 03:34:31PM +0530, Viresh Kumar wrote:
> Each CPU can (and does) participate in cooling down the system but the
> DT only captures a handful of them, normally CPU0, in the cooling maps.
> Things work by chance currently as under normal circumstances its the
> first CPU of each cluster which is used by the operating systems to
> probe the cooling devices. But as soon as this CPU ordering changes and
> any other CPU is used to bring up the cooling device, we will start
> seeing failures.
> 
> Also the DT is rather incomplete when we list only one CPU in the
> cooling maps, as the hardware doesn't have any such limitations.
> 
> Update cooling maps to include all devices affected by individual trip
> points.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, applied for v4.21.
