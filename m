From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 1 Feb 2013 17:14:11 +0530
Subject: [PATCHv2 for soc 3/4] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <20130201113233.GJ23505@n2100.arm.linux.org.uk>
References: <1359651943-21752-1-git-send-email-dinguyen@altera.com>
 <1359651943-21752-4-git-send-email-dinguyen@altera.com>
 <510BA728.4060300@ti.com> <20130201113233.GJ23505@n2100.arm.linux.org.uk>
Message-ID: <510BAA8B.1030506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 01 February 2013 05:02 PM, Russell King - ARM Linux wrote:
> On Fri, Feb 01, 2013 at 04:59:44PM +0530, Santosh Shilimkar wrote:
>> Now since we are moving the code under common place, probably we should
>> update this a function a bit so that it invalidates the CPU cache till
>> line of unification. Just to be consistent with other flush API.
>
> Hmm.  Do you really want a CPU being brought up to do that to the PoU,
> every time that it is brought up?  I thought you wanted to get rid of
> that kind of stuff from the hotplug paths so that a CPU being brought
> up/taken down doesn't affect the caches for the other CPUs within the
> inner sharable domain.
>
You are right. We already git rid of the flush of all cache levels
in hotplug and wakeup paths and now it is restricted till the PoU.

Assuming for the current v7 machines, PoU is L2, invalidating the cache
*till* PoU means only CPU local cache. So the API will in a way
invalidate only local cache.

May be I am missing your point here.

Regards,
Santosh
