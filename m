From: julien.grall@linaro.org (Julien Grall)
Date: Mon, 15 Jul 2013 17:22:00 +0100
Subject: [Xen-devel] [PATCH] xen/arm: disable cpuidle when linux is running
 as dom0
In-Reply-To: <20130715152532.GC5774@phenom.dumpdata.com>
References: <1373898101-15633-1-git-send-email-julien.grall@linaro.org>
 <20130715152532.GC5774@phenom.dumpdata.com>
Message-ID: <51E421A8.1010302@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2013 04:25 PM, Konrad Rzeszutek Wilk wrote:
> On Mon, Jul 15, 2013 at 03:21:41PM +0100, Julien Grall wrote:
>> When linux is running as dom0, Xen doesn't show the physical cpu but a
>> virtual CPU.
>> On some ARM SOC (for instance the exynos 5250), linux registers callbacks
>> for cpuidle. When these callbacks are called, they will modify
>> directly the physical cpu not the virtual one. It can impact the whole board
>> instead of dom0.
> 
> Should you also call disable_cpufreq() ?

I had some issue on the versatile express when cpufreq was disabled.
I will give another try and see the exact error.

-- 
Julien
