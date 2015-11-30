From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 30 Nov 2015 16:04:22 +0530
Subject: [PATCH v4 3/3] thermal: mediatek: Add cpu dynamic power cooling
 model.
In-Reply-To: <1448878884.29031.49.camel@mtksdaap41>
References: <1448616727-29367-1-git-send-email-dawei.chien@mediatek.com>
 <1448616727-29367-4-git-send-email-dawei.chien@mediatek.com>
 <20151130053845.GM3373@ubuntu>
 <1448875581.29031.14.camel@mtksdaap41>
 <20151130093042.GA8556@ubuntu>
 <1448878884.29031.49.camel@mtksdaap41>
Message-ID: <20151130103422.GA4899@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30-11-15, 18:21, dawei chien wrote:
> As far as I know, user or shell script has the right for using command online/offline cpu.

Right.

> Either user by console or shell script could make cpu2 online even cpu2 already onlined.

Hey, no. You can't online that is already online. You can write '1' to
the file /sys/devices/system/cpu/cpuX/online, but it wouldn't have any
affect.

> That could cause of_cpufreq_cooling_register execute many times for the
> same cooling device.

No.

> "echo 1 > /sys/devices/system/cpu/cpu2/online"
> 
> With above hotplug command, mtk_cpufreq_ready will register cooling
> device again as well, but fail since the cooling device already created,
> so we might need not register cooling device again on this case.

Have you tested this yourself ?

-- 
viresh
