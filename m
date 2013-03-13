From: pawel.moll@arm.com (Pawel Moll)
Date: Wed, 13 Mar 2013 11:46:15 +0000
Subject: [PATCH v3 06/11] ARM: vexpress: use clocksource_of_init for sp804
In-Reply-To: <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
References: <1363151142-32162-1-git-send-email-haojian.zhuang@linaro.org>
 <1363151142-32162-7-git-send-email-haojian.zhuang@linaro.org>
 <1363173037.3100.22.camel@hornet>
 <CAD6h2NQWB3+1QepQjBE0BZiG44YAQRi7e-9+oZvVYpYV8QycDA@mail.gmail.com>
Message-ID: <1363175175.3100.37.camel@hornet>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2013-03-13 at 11:42 +0000, Haojian Zhuang wrote:
> > I love the possibility of removing the SP804 code from the VE machine
> > (thanks for your work!), but I'd like to avoid it being replaced by
> > cryptic properties in the tree.
> >
> > Now, to get this right: I'm not saying that there should be completly no
> > OS-specific (but neutral) properties for the clocking system.
> >
> > I'm saying that in "my" (the VE) case, there are four, effectively
> > identical timers (each pair sharing an interrupt though). Every single
> > one of them is perfectly capable of serving as clocksource or
> > clockevent. Therefore I believe the driver/framework/OS should make its
> > own decision.
> >
> I can move those properties into dts file instead.

I'm not sure I understand you here...

> If clocksource uses alias to configure source or event. There's still a lot
> of work. At least we need to split dual timer into two timer devices in DTS.

My point is: at least for VE there is _no need_ for any alias or special
property in the tree (DTS). All timers are equal. The system can (and
should) pick any one it wants.

Pawe?
