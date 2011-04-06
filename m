From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 06 Apr 2011 09:25:45 +0200
Subject: [PATCH 5/7] v4l: s5p-fimc: add pm_runtime support
In-Reply-To: <007c01cbf3f2$c6e7b420$54b71c60$%han@samsung.com>
References: <1302012410-17984-1-git-send-email-m.szyprowski@samsung.com>
	<1302012410-17984-6-git-send-email-m.szyprowski@samsung.com>
	<007c01cbf3f2$c6e7b420$54b71c60$%han@samsung.com>
Message-ID: <000001cbf42b$dbd9db90$938d92b0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Wednesday, April 06, 2011 2:37 AM Jonghun Han wrote:

> runtime_pm is used to minimize current.
> In my opinion, the followings will be better.
> 1. Adds pm_runtime_get_sync before running of the first job.
>    IMO, dma_run callback function is the best place for calling in case of
> M2M.
> 2. And then in the ISR, call pm_runtime_put_sync in the ISR bottom-half if
> there is no remained job.

Right my pm_runtime implementation is very simple. I've just added it to test
if other subsystems are working.

Best regards
--
Marek Szyprowski
Samsung Poland R&D Center
