From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 21 Mar 2016 15:28:55 +0530
Subject: [PATCH] cpufreq: rockchip: add driver
In-Reply-To: <1505152.fhSnu3pvDr@diego>
References: <1458303004-26445-1-git-send-email-xf@rock-chips.com>
 <1787319.AFAWVqkdk0@diego> <20160321095049.GD27778@vireshk-i7>
 <1505152.fhSnu3pvDr@diego>
Message-ID: <20160321095855.GE27778@vireshk-i7>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 21-03-16, 10:54, Heiko St?bner wrote:
> I hadn't seen that yet ... nice that cpufreq-dt now also supports clusters :-)
> 
> The other part still stands though, as we probably should register the 
> platform-device somewhere else and not in some new special module.
> 
> When everything is using cpufreq-dt now, I guess we could just add it to the 
> core rockchip clk-code. Or was there some agreement where this should be done 
> (obviously not the devicetree itself)?

Yeah, there was a discussion around creating a white or black list of platforms
that want to create a platform device for cpufreq-dt. That can be done in
cpufreq-dt.c or a new file, but I haven't worked out on that yet.

You can do it from clk-code or from the driver that was added in this thread.
Just that you need to match your platform's compatible string before doing that.

-- 
viresh
