From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Jan 2016 13:56:22 +0100
Subject: [PATCH] drm/exynos: fix building without CONFIG_PM_SLEEP
In-Reply-To: <56A71075.7070606@samsung.com>
References: <9569056.LBRz4v8fSj@wuerfel> <56A71075.7070606@samsung.com>
Message-ID: <2340022.8FaqkycQpP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 26 January 2016 15:21:41 Inki Dae wrote:
> > -#ifdef CONFIG_PM_SLEEP
> 
> How about just changing it to CONFIG_PM for consistency of other kms drivers?
> Actually, I had modified it to PM since original auther, Gustavo Padovan, posted runtime pm support.
> However, it seems missing this one.

Everybody gets the #ifdef's wrong, so the __maybe_unused approach is
being used increasingly all over the kernel.

	Arnd
