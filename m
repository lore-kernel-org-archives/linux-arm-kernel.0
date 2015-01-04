From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 4 Jan 2015 18:44:13 +0000 (UTC)
Subject: OMAP baseline test results for v3.19-rc1
In-Reply-To: <8185039.GnfXITBRGF@wuerfel>
References: <alpine.DEB.2.02.1501030712210.27058@utopia.booyaka.com>
 <8629693.mvYldWiixb@wuerfel>
 <alpine.DEB.2.02.1501031955170.27058@utopia.booyaka.com>
 <8185039.GnfXITBRGF@wuerfel>
Message-ID: <alpine.DEB.2.02.1501041842210.28771@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 4 Jan 2015, Arnd Bergmann wrote:

> So 3.16 was by far the largest increase, almost 10x bigger than the 3.19 increase, but
> others are quite big as well.
> 
> Do you know what happened in 3.16?

It was commit 1413c03893332366e5b4d1e26f942ada25f3e82a ("lockdep: Increase 
static allocations").


- Paul

commit 1413c03893332366e5b4d1e26f942ada25f3e82a
Author: Sasha Levin <sasha.levin@oracle.com>
Date:   Wed Jan 8 14:21:46 2014 -0500

    lockdep: Increase static allocations
    
    Fuzzing a recent kernel with a large configuration hits the static
    allocation limits and disables lockdep.
    
    This patch doubles the limits.
    
    Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
    Signed-off-by: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/1389208906-24338-1-git-send-email-sasha.levin at oracle.com
    Cc: linux-kernel at vger.kernel.org
    Signed-off-by: Ingo Molnar <mingo@kernel.org>
