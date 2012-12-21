From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 21 Dec 2012 14:10:34 -0700
Subject: [PATCH V3 3/5] ARM: tegra20: clocks: add CPU low-power function
 into tegra_cpu_car_ops
In-Reply-To: <1356066131.26029.26.camel@jlo-ubuntu-64.nvidia.com>
References: <1355797861-12759-1-git-send-email-josephl@nvidia.com>
 <1355797861-12759-4-git-send-email-josephl@nvidia.com>
 <50D34F12.9080801@wwwdotorg.org>
 <1356066131.26029.26.camel@jlo-ubuntu-64.nvidia.com>
Message-ID: <50D4D04A.7000401@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/20/2012 10:02 PM, Joseph Lo wrote:
> On Fri, 2012-12-21 at 01:46 +0800, Stephen Warren wrote:
>> On 12/17/2012 07:30 PM, Joseph Lo wrote:
>>> Add suspend, resume and rail_off_ready API into tegra_cpu_car_ops. These
>>> functions were used for CPU powered-down state maintenance.
>>
>> I think this isn't adding those functions into tegra_cpu_car_ops, but
>> rather implementing the already existing function pointers for Tegra20,
>> right?
>>
> Yes, exactly.
> 
>> This patch touches the clock driver and Prashant will soon be posting
>> patches that significantly rework the clock driver. Those will conflict.
>> How have you worked with Prashant to resolve the conflicts? Will
>> Prashant's patches be based on top of this series? Please explicitly
>> describe the dependencies and resolution of conflicts when you post the
>> next version. (below the ---, along with the changelog)
>>
> Yes, there are many patch series may have dependency each other
> recently. We also want to know what the sequence you expect to merge the
> patch series to your tree.

To be honest, I don't know what order I'd like to merge things yet.
There are so many conflicting/dependant patches for 3.9 flying around
I'd need to re-read them all and think it through in quite some detail...

The common clock rework is something quite important. I'd certainly like
to get that in early. That most likely implies everything else should be
rebased on top of it.

The best thing would be if all patch authors take a look at Prashant's
clock patches (and all other patches) and work out what has dependencies
on what, and co-ordinate with each-other which order is the easiest to
merge things in. Once 3.8-rc1 is out and I can actually start merging
things, I'd like to see a list of outstanding patches from each person,
with all dependencies explicitly listed. I'll use that information to
decide which order to merge in.

Of course I just realized that Prashant hasn't posted his clock patches
upstream yet, so it's a little difficult for anyone to rebase on top of
them yet, but hopefully that will be resolved very soon now...
