From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 11 Sep 2015 13:55:36 +0530
Subject: cpufreq: mediatek: allow modular build
In-Reply-To: <2329563.MhTbBXHVz1@wuerfel>
References: <1768766.yu1lxjsjLL@wuerfel> <20150911081753.GK9650@linux>
 <2329563.MhTbBXHVz1@wuerfel>
Message-ID: <20150911082536.GL9650@linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11-09-15, 10:22, Arnd Bergmann wrote:
> In my approach, I decided to allow the driver to be a module, as that
> seems nicer for multi_v7_defconfig, but I now see that there are
> several other drivers that can only be built-in, so if we decided to
> make that the general strategy we should change them all.

And we need to do that with a proper module_exit() function, otherwise
we are really adding a BUG. Which you just did with your patch :)

-- 
viresh
