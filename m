From: mika.penttila@nextfour.com (=?UTF-8?Q?Mika_Penttil=c3=a4?=)
Date: Mon, 22 Feb 2016 17:34:07 +0200
Subject: arm: set_memory_xx fixes patch missing?
In-Reply-To: <20160222150911.GA25429@luxor.wired.org>
References: <20160222150911.GA25429@luxor.wired.org>
Message-ID: <56CB2A6F.5060006@nextfour.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22.02.2016 17:09, Paolo Pisati wrote:
> What's happened to the arm side of this patch:
>
> http://lkml.iu.edu/hypermail/linux/kernel/1601.2/04934.html
>
> the arm64 code is already in Linus's tree, while it seems like the arm part was
> lost and forgotten, and i don't see it in rmk's patch queue.

Hi,

Yes, it for sure should go in, please apply:

----------------------------------------------------
From: Mika Penttil? <mika.penttila@nextfour.com>

Allow zero size updates. This makes set_memory_xx() consistent with x86, s390 and arm64.

Signed-off-by: Mika Penttil? mika.penttila at nextfour.com

---
 arch/arm/mm/pageattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mm/pageattr.c b/arch/arm/mm/pageattr.c
index be7fe4b..9edf6b0 100644
--- a/arch/arm/mm/pageattr.c
+++ b/arch/arm/mm/pageattr.c
@@ -49,6 +49,9 @@ static int change_memory_common(unsigned long addr, int numpages,
 		WARN_ON_ONCE(1);
 	}
 
+	if (!numpages)
+		return 0;
+
 	if (start < MODULES_VADDR || start >= MODULES_END)
 		return -EINVAL;
 
-- 1.9.1
