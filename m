From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 13 Sep 2013 16:53:13 +0100
Subject: [PATCH 181/228] cpufreq: move freq change notifications to
 cpufreq core
In-Reply-To: <fd43341751c7a00d2f4eedf48d6338f866b26a52.1379063063.git.viresh.kumar@linaro.org>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <fd43341751c7a00d2f4eedf48d6338f866b26a52.1379063063.git.viresh.kumar@linaro.org>
Message-ID: <20130913155313.GA12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 13, 2013 at 06:32:07PM +0530, Viresh Kumar wrote:
> +		read_lock_irqsave(&cpufreq_driver_lock, flags);
> +		notify = !(cpufreq_driver->flags & CPUFREQ_ASYNC_NOTIFICATION);
> +		read_unlock_irqrestore(&cpufreq_driver_lock, flags);

I don't think this needs to be read under a lock - if this bit changes
dynamically, then there's something very wrong.
