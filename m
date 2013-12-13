From: steve.capper@linaro.org (Steve Capper)
Date: Fri, 13 Dec 2013 12:06:29 +0000
Subject: [PATCH 0/2] Cache flush fixes
Message-ID: <1386936391-30493-1-git-send-email-steve.capper@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set fixes a couple of cache flushing problems that I ran
into recently, whilst running libhugetlbfs tests (mainly the
icache-hygiene test).

One problem was due to not flushing enough, the other was due to
flushing too much. Hopefully, this patch set makes things jussst
right :-).

I am not sure whether or not these should be marked as for stable?

Cheers,
-- 
Steve

Steve Capper (2):
  arm: mm: fix dcache flush logic for compound high pages
  arm: cacheflush: Fix user split-caching logic

 arch/arm/kernel/traps.c |  2 +-
 arch/arm/mm/flush.c     | 11 ++++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

-- 
1.8.1.4
