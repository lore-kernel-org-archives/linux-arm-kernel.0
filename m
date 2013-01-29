From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 10:36:18 -0800
Subject: [GIT PULL] Samsung fixes-4 for v3.8
In-Reply-To: <06c601cdfe4b$01ef8890$05ce99b0$@samsung.com>
References: <06c601cdfe4b$01ef8890$05ce99b0$@samsung.com>
Message-ID: <20130129183618.GA19906@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 10:03:54AM -0800, Kukjin Kim wrote:
> Hi Arnd and Olof,
> 
> Here is a pull request for Samsung fixes-4 for v3.8.
> 
> This fixes compatible values for exynos pinctrl and crash on soft reset,
> tick and alarm irq numbers on exynos5440 and uninitialized variable on
> s3c24xx.
> 
> If any problems, please kindly let me know.
> 
> Thanks.
> 
> - Kukjin
> 
> The following changes since commit 949db153b6466c6f7cad5a427ecea94985927311:
> 
>   Linux 3.8-rc5 (2013-01-25 11:57:28 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.8-samsung-fixes-4

Pulled, but...

> for you to fetch changes up to 60db7e5f9c9a25a7a9b01007e6e3f5a93bc16a3a:
> 
>   ARM: EXYNOS: Fix crash on soft reset on EXYNOS5440 (2013-01-28 14:27:50
> -0800)
> 
> ----------------------------------------------------------------
> Cong Ding (1):
>       ARM: S3C24XX: fix uninitialized variable warning

Hm, that whole loop looks bogus. The compiler is still free to optimize
it away since 'tmp' isn't actually used anywhere. It's just not good
enough at it yet.  :)


-Olof
