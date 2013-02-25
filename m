From: jacob.jun.pan@linux.intel.com (Jacob Pan)
Date: Mon, 25 Feb 2013 15:00:35 -0800
Subject: [PATCH 2/2][RFC] time : set broadcast irq affinity
In-Reply-To: <512BEAAF.1070500@linaro.org>
References: <5123C299.3080005@linaro.org>
 <1361484083-5906-1-git-send-email-daniel.lezcano@linaro.org>
 <1361484083-5906-2-git-send-email-daniel.lezcano@linaro.org>
 <20130222095530.377fd218@chromoly> <512BEAAF.1070500@linaro.org>
Message-ID: <20130225150035.7ddf6643@chromoly>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Feb 2013 23:50:23 +0100
Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> Do you mean a cpumask static variable ? and something like:
> 
> if (!cpumask_test_cpu(cpu, &affinitymask)) {
> 	cpumask_set_cpu(cpu, &affinitymask);
> 	irq_set_affinity(bc->irq, &affinitymask)
> }
yeah. but i think you can use the cpumask in struct clock_event_device.

-- 
Thanks,

Jacob
