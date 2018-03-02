From: will.deacon@arm.com (Will Deacon)
Date: Fri, 2 Mar 2018 10:30:46 +0000
Subject: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
In-Reply-To: <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
 <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
Message-ID: <20180302103046.GC19323@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 05:02:32PM +0800, Alex Shi wrote:
> As testing the spectre bug fix, that's a good question. I also asked
> this question to original patch authors, like Marc. They said they just
> figure out these patches could block spectre or meltdown issue. From my
> side, I just reproduced the process internal spectre. But all fix on arm
> can not resolve the user space internal spectre. It can block from user
> to kernel or kernel to user spectre according the code purose. So I
> believe these patch could do their job. And arm cpu would drop the
> spectre branches if it has 20+ 'nop' instructions...

Since this is archived on a public list and I don't want people to rely on
this, no, you cannot rely on "20+ 'nop' instructions" to work around
spectre on arm/arm64. It might prevent a particular PoC working on a
particular SoC, but it's fragile at best.

Will
