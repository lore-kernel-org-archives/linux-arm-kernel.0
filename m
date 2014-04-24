From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 Apr 2014 11:36:39 +0100
Subject: [PATCH V2 0/5] Huge pages for short descriptors on ARM
In-Reply-To: <20140424102229.GA28014@linaro.org>
References: <1397648803-15961-1-git-send-email-steve.capper@linaro.org>
 <20140424102229.GA28014@linaro.org>
Message-ID: <20140424103639.GC19564@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steve,

On Thu, Apr 24, 2014 at 11:22:29AM +0100, Steve Capper wrote:
> On Wed, Apr 16, 2014 at 12:46:38PM +0100, Steve Capper wrote:
> Just a ping on this...
> 
> I would really like to get huge page support for short descriptors on
> ARM merged as I've been carrying around these patches for a long time.
> 
> Recently I've had no issues raised about the code. The patches have
> been tested and found to be both beneficial to system performance and
> stable.
> 
> There are two parts to the series, the first patch is a core mm/ patch
> that introduces some huge_pte_ helper functions that allows for a much
> simpler ARM (without LPAE) implementation. The second part is the
> actual arch/arm code.
> 
> I'm not sure how to proceed with these patches. I was thinking that
> they could be picked up into linux-next? If that sounds reasonable;
> Andrew, would you like to take the mm/ patch and Russell could you
> please take the arch/arm patches?
> 
> Also, I was hoping to get these into 3.16. Are there any objections to
> that?

Who is asking for this code? We already support hugepages for LPAE systems,
so this would be targetting what? A9? I'm reluctant to add ~400 lines of
subtle, low-level mm code to arch/arm/ if it doesn't have any active users.

I guess I'm after some commitment that this is (a) useful to somebody and
(b) going to be tested regularly, otherwise it will go the way of things
like big-endian, where we end up carrying around code which is broken more
often than not (although big-endian is more self-contained).

Will
