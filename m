From: khilman@ti.com (Kevin Hilman)
Date: Wed, 24 Aug 2011 16:15:28 -0700
Subject: [GIT PULL] I2C: OMAP: misc. fixes for v3.2
In-Reply-To: <20110824215706.GH19115@trinity.fluff.org> (Ben Dooks's message
	of "Wed, 24 Aug 2011 22:57:06 +0100")
References: <87bovfhdsz.fsf@ti.com> <20110824215706.GH19115@trinity.fluff.org>
Message-ID: <87aaay765r.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ben Dooks <ben-i2c@fluff.org> writes:

> On Tue, Aug 23, 2011 at 05:07:56PM -0700, Kevin Hilman wrote:
>> Hi Ben,
>> 
>> Initially, these fixes were planned to be queued for v3.1-rc, but since
>> the previous series from Andy didn't make it into v3.1, it should be
>> queued for v3.2.
>> 
>> This branch is based on the for_3.2/i2c-andy branch (previous pull request.)
>> 
>> Please pull into your tree for linux-next.
>> 
>> Thanks,
>> 
>> Kevin
>> 
>> The following changes since commit 48cc1edc8f6b65a9500c8f1d93db6038167da8f0:
>> 
>>   I2C: OMAP1/OMAP2+: prepend I2C IP version to probed version shown in dev_info (2011-08-23 10:51:45 -0700)
>> 
>> are available in the git repository at:
>>   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/i2c-fixes
>> 
>> Kevin Hilman (1):
>>       Revert "i2c-omap: fix static suspend vs. runtime suspend"
>
> I've got this one, I assume it can be submitted without being based
> on the Andy Green series.

Well, the original version posted had a bug (thanks Felipe), so you need
to be sure you have the one from this branch.

Actually, this one (the revert commit) should also be submitted for
v3.1-rc, since this is a known bug/race in v3.1.

To that end, I reworked the branches slightly.  The patch above now
lives in my for_3.1/i2c-fixes branch (based on v3.1-rc3.)  This should
be submitted for v3.1-rc.

The other patch in this series is still in the v3.2/i2c-fixes branch
(based on Andy's branch, and merges for_3.1/i2c-fixes.)

The 2nd cleanup series (for_3.2/i2c-cleanup) was then simply rebased
onto for_3.2/i2c-fixes.

That should help clarify the dependences and also make it easy to get
the revert in for v3.1-rc as well.

Thanks,

Kevin
