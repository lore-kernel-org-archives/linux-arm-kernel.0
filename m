From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Mon, 16 Oct 2017 14:48:54 +0200
Subject: [PATCH 0/2] fix lockdep warnings in s5p_mfc and exynos-gsc vb2
 drivers
In-Reply-To: <cover.1507935819.git.shuahkh@osg.samsung.com>
References: <CGME20171013231531epcas5p2f009317ed58f5177e7a0768b69a62b6c@epcas5p2.samsung.com>
 <cover.1507935819.git.shuahkh@osg.samsung.com>
Message-ID: <c2dae5ff-a35c-bdd1-910b-75db6c9c16b2@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shuah,

On 2017-10-14 01:13, Shuah Khan wrote:
> Driver mmap functions shouldn't hold lock when calling vb2_mmap(). The
> vb2_mmap() function has its own lock that it uses to protect the critical
> section.
>
> Reference: commit log for f035eb4e976ef5a059e30bc91cfd310ff030a7d3

It would make sense to add the information about the reference commit to 
each
commit message and also point to commit 
e752577ed7bf55c81e10343fced8b378cda2b63b,
as it is exactly the same case here. Anyway:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

I wonder if makes sense to send those patches also to stable at vget.kernel.org
(maybe v4.3+, like the mentioned above commit, if they really apply?).

> Shuah Khan (2):
>    media: exynos-gsc: fix lockdep warning
>    media: s5p-mfc: fix lockdep warning
>
>   drivers/media/platform/exynos-gsc/gsc-m2m.c | 5 -----
>   drivers/media/platform/s5p-mfc/s5p_mfc.c    | 3 ---
>   2 files changed, 8 deletions(-)
>

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
