From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 07 Jan 2014 14:31:59 +0100
Subject: [PATCH V2 03/10] pinctrl: exynos: add exynos5260 SoC specific data
In-Reply-To: <1389099548-14649-4-git-send-email-rahul.sharma@samsung.com>
References: <1389099548-14649-1-git-send-email-rahul.sharma@samsung.com>
 <1389099548-14649-4-git-send-email-rahul.sharma@samsung.com>
Message-ID: <3846194.a18yHpXxuP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 07 January 2014 18:29:01 Rahul Sharma wrote:
> From: Young-Gun Jang <yg1004.jang@samsung.com>
> 
> Add Samsung Exynos5260 SoC specific data to enable pinctrl
> support for all platforms based on EXYNOS5260.
> 
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Young-Gun Jang <yg1004.jang@samsung.com>
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Arun Kumar K <arun.kk@samsung.com>

On a similar note to the comment about the platform patch, I think
it would be good to extend the DT binding in a way that allows
you to describe the differences between the SoCs without having
to change the driver every time a new model comes out.

We still have to maintain backwards compatibility with the
existing bindings I suppose, but I'd rather not see new ones
added like this. I realize that there is a tradeoff between
having too much information in DT when it is always fixed, and
having too much hardcoded in the driver, and at some point there
was a conscious decision to do it like this, but I fear the
tradeoff has changed with the number of EXYNOS implementations
that really only differ in their pin banks.

	Arnd
