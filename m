From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 28 Apr 2016 10:20:23 +0200
Subject: [PATCH] ARM: cpuidle: Pass on arm_cpuidle_suspend()'s return value
In-Reply-To: <20160427091434.GA4303@red-moon>
References: <1461669301-30834-1-git-send-email-james.morse@arm.com>
 <20160426113103.GB2204@red-moon>
 <CAJZ5v0h+P5baWVkTcbjxOjsXyp7aDy25+ik_9XHtUs6+jeN7Pw@mail.gmail.com>
 <20160427091434.GA4303@red-moon>
Message-ID: <20160428082023.GA10216@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 27, 2016 at 10:14:34AM +0100, Lorenzo Pieralisi wrote:
> [+ Lina]
> 
> On Tue, Apr 26, 2016 at 09:05:57PM +0200, Rafael J. Wysocki wrote:
> > On Tue, Apr 26, 2016 at 1:31 PM, Lorenzo Pieralisi
> > <lorenzo.pieralisi@arm.com> wrote:
> > > On Tue, Apr 26, 2016 at 12:15:01PM +0100, James Morse wrote:
> > >> arm_cpuidle_suspend() may return -EOPNOTSUPP, or any value returned
> > >> by the cpu_ops/cpuidle_ops suspend call. arm_enter_idle_state() doesn't
> > >> update 'ret' with this value, meaning we always signal success to
> > >> cpuidle_enter_state(), causing it to update the usage counters as if we
> > >> succeeded.
> > >>
> > >> Fixes: 191de17aa3c1 ("ARM64: cpuidle: Replace cpu_suspend by the common ARM/ARM64 function")
> > >> Signed-off-by: James Morse <james.morse@arm.com>
> > >> ---
> > >>  drivers/cpuidle/cpuidle-arm.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
