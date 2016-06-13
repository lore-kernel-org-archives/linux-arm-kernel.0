From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 13 Jun 2016 18:12:11 +0200
Subject: [PATCH 1/5] soc: qcom: Add suspend to idle support
In-Reply-To: <20160609180902.GJ13357@hector.attlocal.net>
References: <1463634020-17252-1-git-send-email-andy.gross@linaro.org>
 <1463634020-17252-2-git-send-email-andy.gross@linaro.org>
 <CAPDyKFrAGVPkc=ycm-cQg6Y5NLx_d4xGeg8SaSiB-K5sxtv76A@mail.gmail.com>
 <20160609180902.GJ13357@hector.attlocal.net>
Message-ID: <20160613161211.GG10634@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2016 at 01:09:02PM -0500, Andy Gross wrote:
> On Thu, Jun 09, 2016 at 09:39:34AM +0200, Ulf Hansson wrote:
> > + Daniel
> > 
> > On 19 May 2016 at 07:00, Andy Gross <andy.gross@linaro.org> wrote:

[ ... ]

> > I don't think this will work!
> > 
> > When building a multi defconfig for ARM, you might overwrite the
> > suspend_ops (there's only one set) as here you don't know that it's
> > actually the QCOM platform that is running, right!?
> > 
> > Perhaps this code actually belongs closer to the cpuidle driver?
> 
> Hmmmm, I might have to get creative.  I originally had a DT entry for the pm,
> but that doesn't make sense as this is purely a software construct.  The db410c
> uses the arm cpuidle driver so I can't really hook it in there.  I'll have to
> come up with something else.

IMO, the generic ARM driver should be revisited to add support for suspend 
to idle.
