From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 12 May 2015 17:51:17 +0200
Subject: [PATCH 5/8] dmaengine: mv_xor: bug fix for racing condition in
 descriptors cleanup
In-Reply-To: <1431445063-20226-6-git-send-email-maxime.ripard@free-electrons.com>
References: <1431445063-20226-1-git-send-email-maxime.ripard@free-electrons.com>
 <1431445063-20226-6-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150512175117.1eaff739@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime,

On Tue, 12 May 2015 17:37:40 +0200, Maxime Ripard wrote:
> From: Lior Amsalem <alior@marvell.com>
> 
> This patch fixes a bug in the XOR driver where the cleanup function can be
> called and free descriptors that never been processed by the engine (which
> result in data errors).
> 
> The cleanup function will free descriptors based on the ownership bit in
> the descriptors.
> 
> Signed-off-by: Lior Amsalem <alior@marvell.com>
> Reviewed-by: Ofer Heifetz <oferh@marvell.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

If this is fixing a bug, shouldn't it be Cc'ed to stable@ ? But then it
needs to be the first patch in the series.

>From what I remember, this series both fixes some issues *and* adds
RAID6 support. We need to separate out the two things so that the fixes
can be propagated to stable.

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
