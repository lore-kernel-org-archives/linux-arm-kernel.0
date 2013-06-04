From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Jun 2013 19:37:54 +0100
Subject: [PATCH 00/11] drivers: Add Pinctrl PM support
In-Reply-To: <87k3m92148.fsf@linaro.org>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
 <20130531170437.GA17591@core.coreip.homeip.net>
 <CACRpkdYnhjpFp1CM=P_hddBe4qVigtE0c+CN9NKvk3nFgJS-ig@mail.gmail.com>
 <87k3m92148.fsf@linaro.org>
Message-ID: <20130604183754.GT31367@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 04, 2013 at 11:15:51AM -0700, Kevin Hilman wrote:
> Linus Walleij <linus.walleij@linaro.org> writes:

> > I think this will save a *lot* of identical code in all the
> > drivers, that will just have to call
> > pinctrl_select_pm_sleep(), pinctrl_select_pm_default()
> > pinctrl_select_pm_idle() instead of all the complex code.

> > This is what I planned to do but never got around to.

> What about taking it one tiny step further, and having it done by the PM
> core itself?

> Seems like something that should just be done as part of runtime PM
> transitions and the suspend/resume process.

Indeed, I remember suggesting this as part of the original discussion of
having the code do the default state setting.  It seems like there ought
to be very few devices which actively manage pinctrl themselves,
otherwise we'll get a lot of boilerplate.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130604/aea822c8/attachment.sig>
