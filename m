From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 09 Apr 2012 12:41:39 +0530
Subject: [PATCHv2 0/5] coupled cpuidle state support
In-Reply-To: <4F75ACCA.4090009@ti.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
 <CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
 <4F75ACCA.4090009@ti.com>
Message-ID: <4F828BAB.5010302@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 30 March 2012 06:23 PM, Santosh Shilimkar wrote:
> Colin,
> 
> On Friday 16 March 2012 05:07 AM, Colin Cross wrote:
>> On Wed, Mar 14, 2012 at 11:29 AM, Colin Cross <ccross@android.com> wrote:
> 
> [...]
> 
>>>
>>> v2:
>>>   * removed the coupled lock, replacing it with atomic counters
>>>   * added a check for outstanding pokes before beginning the
>>>     final transition to avoid extra wakeups
>>>   * made the cpuidle_coupled struct completely private
>>>   * fixed kerneldoc comment formatting
>>>   * added a patch with a helper function for resynchronizing
>>>     cpus after aborting idle
>>>   * added a patch (not for merging) to add trace events for
>>>     verification and performance testing
>>
>> I forgot to mention, this patch series is on v3.3-rc7, and will
>> conflict with the cpuidle timekeeping patches.  If those go in first
>> (which is likely), I will rework this series on top of it.  I left it
>> on v3.3-rc7 now to make testing easier.
> 
> I have re-based your series against Len Browns
> next branch [1] which has time keeping and other cpuidle patches.
> Have also folded the CPU hotplug fix which I posted in the
> original coupled idle patch.
> 
As you know, we have been playing around this series for OMAP
for last few weeks. This version series seems to work as intended
and found it pretty stable in my testing. Apart from the cpu
hotplug fix and the trace event comment, series looks fine
to me.

FWIW,
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	

An updated version of this series along with OMAP cpuidle
driver updates against 3.4-rc2 is available here [1] in
case some body is interested looking at it.

Regards
Santosh

[1] git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.5/coupled_cpuidle-rebase
