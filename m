From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Fri, 13 Sep 2013 21:59:10 +0530
Subject: [PATCH 106/228] cpufreq: integrator: don't initialize part of
 policy that is set by core too
In-Reply-To: <20130913161059.GD12758@n2100.arm.linux.org.uk>
References: <cover.1379063063.git.viresh.kumar@linaro.org>
 <6d8d406ebca886e5147191cc8c333d926ef9eb30.1379063063.git.viresh.kumar@linaro.org>
 <20130913161059.GD12758@n2100.arm.linux.org.uk>
Message-ID: <CAKohponAWXXCVtDL1=C5sQv0QB03P4jtkyE7N+=DDdGPLZpW_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 September 2013 21:40, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> This patch actually changes things - the description is misleading.
> Please explain why this change - which results in different values for
> policy->min and policy->max doesn't cause any functional difference.

Yeah, see if below log looks correct (patch attached):

Subject: [PATCH 106/228] cpufreq: integrator: don't initialize part of policy
 that is set by core too

Many common initializations of struct policy are moved to core now and hence
this driver doesn't need to do it. This patch removes such code.

Most recent of those changes is to call ->get() in the core after calling
->init(). And so we don't need to set policy->cur from driver anymore.

Over that it sets policy->min and max correctly. They were earlier set to
current frequency of CPU but they should be set to max and min freq of cpu.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/integrator-cpufreq.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0106-cpufreq-integrator-don-t-initialize-part-of-policy-t.patch
Type: application/octet-stream
Size: 1805 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130913/e71c1e56/attachment.obj>
