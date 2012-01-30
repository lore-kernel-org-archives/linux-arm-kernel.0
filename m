From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 30 Jan 2012 11:16:12 +0200
Subject: [Linaro-mm-sig] [PATCH 12/15] drivers: add Contiguous Memory
 Allocator
In-Reply-To: <014101ccdf22$eb610d30$c2232790$%szyprowski@samsung.com>
References: <1327568457-27734-1-git-send-email-m.szyprowski@samsung.com>
 <1327568457-27734-13-git-send-email-m.szyprowski@samsung.com>
 <CADMYwHw1B4RNV_9BqAg_M70da=g69Z3kyo5Cr6izCMwJ9LAtvA@mail.gmail.com>
 <00de01ccdce1$e7c8a360$b759ea20$%szyprowski@samsung.com>
 <CAO8GWqnQg-W=TEc+CUc8hs=GrdCa9XCCWcedQx34cqURhNwNwA@mail.gmail.com>
 <010301ccdd03$1ad15ab0$50741010$%szyprowski@samsung.com>
 <CAK=WgbZWHBKNQwcoY9OiXXH-r1n3XxB=ZODZJN-3vZopU2yhJA@mail.gmail.com>
 <010501ccdd06$b9844f20$2c8ced60$%szyprowski@samsung.com>
 <CAK=WgbY3L7u0AC1c=iNvoMXX+LSJoz1W-xb=S6gmhqcse5CKaA@mail.gmail.com>
 <014101ccdf22$eb610d30$c2232790$%szyprowski@samsung.com>
Message-ID: <CAK=WgbaDpbeMGZ4eyPv6bGRFibQ8EaQ8kk5DQZ_qwDoMorD6uQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marek,

On Mon, Jan 30, 2012 at 9:43 AM, Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
> Did you managed to fix this issue?

Yes -- the recent increase in the vmalloc region triggered a bigger
truncation in the system RAM than we had before, and therefore
conflicted with the previous hardcoded region we were using.

Long term, our plan is to get rid of those hardcoded values, but for
the moment our remote RTOS still needs to know the physical address in
advance.

> Right, thanks for spotting it, I will squash it to the next release.

Thanks. With that hunk squashed in, feel free to add my Tested-by tag
to the patches.

Thanks!
Ohad.
