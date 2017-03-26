From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 26 Mar 2017 17:20:50 +0200
Subject: [PATCH 0/5] Convert to use devm_*() for amba attached modules
In-Reply-To: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
References: <1490539314-9681-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20170326152050.v47z36eud6xvrcpt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/03/2017 at 22:41:49 +0800, Leo Yan wrote:
> When review device driver modules which attach to amba bus, found
> several modules are not using devm_*() apis to manage resource. As
> result, some drivers have memory leakage or missing iomem unmapping
> when rmmod module. And the code has many "goto" tags to handle
> different failures.
> 
> So this patch series is to convert to use devm_*() for moudules which
> are attached to amba bus to manage resource and get more robust and
> neat code.
> 
> Patch 0003 "drivers/rtc/rtc-pl031.c: Convert to use devm_*()" has been
> verified on 96boards Hikey. Other patches can pass building but have
> not really tested on hardware.
> 

If your plan is to actually remove usage of
amba_request_regions() and amba_release_regions(), you should do so in
its own patch sets instead of hiding that in a useless cleanup series.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
