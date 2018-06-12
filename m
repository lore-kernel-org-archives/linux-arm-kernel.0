From: guohanjun@huawei.com (Hanjun Guo)
Date: Tue, 12 Jun 2018 09:14:46 +0800
Subject: [PATCH 0/5] arm64: numa/topology/smp: fix the cpumasks for CPU
 hotplug
In-Reply-To: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
References: <1528108797-13743-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <23796631-312b-82a0-fe03-cb7985433727@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sudeep,

On 2018/6/4 18:39, Sudeep Holla wrote:
> Hi Will, Catalin, Jeremy, Morten,
> 
> This is the fix I could come up for the issues we are seeing with arm64
> for-next branch, in particular with commit 37c3ec2d810f ("arm64: topology:
> divorce MC scheduling domain from core_siblings").
> 
> The solution is to update the CPU topology during CPU hotplug operations
> similar to other architectures like x86 and PPC. This is also inline
> with the expection from the scheduler.
> 
> I have cc-ed few Cavium and Huawei guys as they seem to have added or
> modified the numa related code in the past.

Sorry for the late response, I can test on ARM64 NUMA systems
with PPTT enabled, before I'm doing that, could you give some
suggestion of the testing? what specific test case should I
test? doing CPU offline/online when PPTT is enabled?

Thanks
Hanjun
