From: ccross@android.com (Colin Cross)
Date: Wed, 16 Jan 2013 14:51:42 -0800
Subject: [PATCH V4 5/5] ARM: tegra20: cpuidle: apply coupled cpuidle for
 powered-down mode
In-Reply-To: <50F71C21.20904@wwwdotorg.org>
References: <1358323873-30525-1-git-send-email-josephl@nvidia.com>
 <CAMbhsRTmGVrjnKa_z+zonGypU+U4r2iE=D-Zfvyoq8chY68QKQ@mail.gmail.com>
 <50F71C21.20904@wwwdotorg.org>
Message-ID: <CAMbhsRTXOgKCJjuapdGFhM9JNi0+V-dWPormDSE3tQ4rO1i1yg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 16, 2013 at 1:31 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> On 01/16/2013 11:55 AM, Colin Cross wrote:
>> On Wed, Jan 16, 2013 at 12:11 AM, Joseph Lo <josephl@nvidia.com> wrote:
>>> The "powered-down" cpuidle mode of Tegra20 needs the CPU0 be the last one
>>> core to go into this mode before other core. The coupled cpuidle framework
>>> can help to sync the MPCore to coupled state then go into "powered-down"
>>> idle mode together. The driver can just assume the MPCore come into
>>> "powered-down" mode at the same time. No need to take care if the CPU_0
>>> goes into this mode along and only can put it into safe idle mode (WFI).
>>>
>>> The powered-down state of Tegra20 requires power gating both CPU cores.
>>> When the secondary CPU requests to enter powered-down state, it saves
>>> its own contexts and then enters WFI for waiting CPU0 in the same state.
>>> When the CPU0 requests powered-down state, it attempts to put the secondary
>>> CPU into reset to prevent it from waking up. Then power down both CPUs
>>> together and power off the cpu rail.
>>>
>>> Be aware of that, you may see the legacy power state "LP2" in the code
>
> Colin, since you only raised a few small issues on this series, does
> that mean you're OK with it once those issues are fixed?

I didn't review the Tegra-specific parts careful, but from the coupled
cpuidle perspective, with the comments I pointed out,
Acked-by: Colin Cross <ccross@android.com>

> Joseph, we'll be merging Tegra114 in the near future. How will this
> patch series affect Tegra114? Will the cpuidle driver simply fail to
> register on Tegra114 (which would be fine until we explicitly add
> support), or would we need to disable cpuidle in Kconfig to get a
> working Tegra114 kernel. Does this patch series affect the answer to the
> previous question? Thanks.
>
