From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 19 Feb 2018 09:13:38 +0530
Subject: [PATCH 10/10] dt-bindings: thermal: Remove
 "cooling-{min|max}-level" properties
In-Reply-To: <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
References: <cover.1518166039.git.viresh.kumar@linaro.org>
 <0ec53640f1a09e6e0d7aa1a21d1a3266c3c209c7.1518166039.git.viresh.kumar@linaro.org>
 <20180218232906.jkpymin3a4qxjhnc@rob-hp-laptop>
Message-ID: <20180219034338.GI28462@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18-02-18, 17:29, Rob Herring wrote:
> On Fri, Feb 09, 2018 at 02:28:10PM +0530, Viresh Kumar wrote:
> > The "cooling-min-level" and "cooling-max-level" properties are not
> > parsed by any part of kernel currently and the max cooling state of a
> > CPU cooling device is found by referring to the cpufreq table instead.
> 
> What about non-CPU devices? A fan for example.

Even they aren't using these properties. The gpio-fan binding[1] for
example uses the "gpio-fan,speed-map" property instead to find the
number of states it supports.

-- 
viresh

[1] Documentation/devicetree/bindings/gpio/gpio-fan.txt
