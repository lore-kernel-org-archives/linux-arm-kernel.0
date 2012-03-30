From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 30 Mar 2012 18:23:30 +0530
Subject: [PATCHv2 0/5] coupled cpuidle state support
In-Reply-To: <CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
References: <1331749794-8056-1-git-send-email-ccross@android.com>
 <CAMbhsRQAw2+as13NVvWkh7ojyRs+jNpFist2gmiiEY52U=o84A@mail.gmail.com>
Message-ID: <4F75ACCA.4090009@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Colin,

On Friday 16 March 2012 05:07 AM, Colin Cross wrote:
> On Wed, Mar 14, 2012 at 11:29 AM, Colin Cross <ccross@android.com> wrote:

[...]

>>
>> v2:
>>   * removed the coupled lock, replacing it with atomic counters
>>   * added a check for outstanding pokes before beginning the
>>     final transition to avoid extra wakeups
>>   * made the cpuidle_coupled struct completely private
>>   * fixed kerneldoc comment formatting
>>   * added a patch with a helper function for resynchronizing
>>     cpus after aborting idle
>>   * added a patch (not for merging) to add trace events for
>>     verification and performance testing
> 
> I forgot to mention, this patch series is on v3.3-rc7, and will
> conflict with the cpuidle timekeeping patches.  If those go in first
> (which is likely), I will rework this series on top of it.  I left it
> on v3.3-rc7 now to make testing easier.

I have re-based your series against Len Browns
next branch [1] which has time keeping and other cpuidle patches.
Have also folded the CPU hotplug fix which I posted in the
original coupled idle patch.

If you want, the updated branch can be pulled from:

git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
for_3.5/coupled_cpuidle-rebase

Regards
Santosh

[1] Power Management
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
