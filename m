From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 30 Nov 2011 11:06:40 +0000
Subject: [PATCH V3 3/6] ARM: exynos: save L2 settings during bootup
In-Reply-To: <20111122094925.GV9581@n2100.arm.linux.org.uk>
References: <1321954532-18724-1-git-send-email-amit.kachhap@linaro.org>
 <1321954532-18724-4-git-send-email-amit.kachhap@linaro.org>
 <20111122094925.GV9581@n2100.arm.linux.org.uk>
Message-ID: <20111130110640.GA3018@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 22, 2011 at 09:49:25AM +0000, Russell King - ARM Linux wrote:
> On Tue, Nov 22, 2011 at 03:05:29PM +0530, Amit Daniel Kachhap wrote:
> > This patch adds code to save L2 register configuration at boot, and
> > later used to resume L2 before MMU is enabled in suspend and cpuidle
> > resume paths.
> 
> Is there a reason exynos isn't using the generic l2 code?

As far as registers saving is concerned answer is no (or better, DT
support).
That code was there waiting for DT support (it should use l2x0_of_init, which 
depends on DT support for exynos).

Thanks,
Lorenzo
