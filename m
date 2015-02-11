From: pavel@ucw.cz (Pavel Machek)
Date: Wed, 11 Feb 2015 23:12:33 +0100
Subject: [PATCH v3 20/20] arm: mach-pxa: Decrement the power supply's
 device reference counter
In-Reply-To: <1423476432.4909.15.camel@AMDC1943>
References: <1422629278-12202-1-git-send-email-k.kozlowski@samsung.com>
 <1422629278-12202-21-git-send-email-k.kozlowski@samsung.com>
 <20150206134953.GA25683@amd> <1423233788.31516.5.camel@AMDC1943>
 <20150206145904.GA7872@amd> <1423476432.4909.15.camel@AMDC1943>
Message-ID: <20150211221233.GD11313@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2015-02-09 11:07:12, Krzysztof Kozlowski wrote:
> On pi?, 2015-02-06 at 15:59 +0100, Pavel Machek wrote:
> > On Fri 2015-02-06 15:43:08, Krzysztof Kozlowski wrote:
> > > On pi?, 2015-02-06 at 14:49 +0100, Pavel Machek wrote:
> > > > On Fri 2015-01-30 15:47:58, Krzysztof Kozlowski wrote:
> > > > > Use power_supply_put() to decrement the power supply's device reference
> > > > > counter.
> > > > > 
> > > > > Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > > > > Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > > > > Reviewed-by: Sebastian Reichel <sre@kernel.org>
> > > > 
> > > > 11,13,20 nothing obviously wrong. But I'm not sure if I studied them
> > > > closely enough to warrant an ACK.
> > > > 
> > > > It would be good to get this into kernel -- I seen no bad comments,
> > > > and it is not going to improve without merge into mainline.
> > > 
> > > Thanks for looking at patchset. It would be really nice if this could be
> > > tested for some time in linux-next. Such testing would help a lot. But I
> > > need acks from various maintainers for that.
> > 
> > Actually, you don't. The various maintainers clearly don't care at
> > this point. They had enough time. So you select one maintainer you
> > want to push this through, and you push it.
> > 
> > Someone may complain, so you'll solve the feedback...
> 
> I am thinking also on another way of solving this huge-patch problem:
> 1. Mark all drivers broken (CONFIG_BROKEN).
> 2. Introduce change in power_supply_register() API. Broken drivers
>    will fail to build.
> 3. Convert broken drivers to new API incrementally (one driver
>    per patch) marking them also non-broken.
> 
> This would be much easier to review but also this would break
> build-bisectability for drivers and some platforms using them (like
> OLPC, compal-laptop, ACPI).

It is easy enough to review as it is, playing with CONFIG_BROKEN will
not improve it. Just push the patch...

> I pushed the patchset here:
> https://git.linaro.org/people/marek.szyprowski/linux-srpol.git/shortlog/refs/heads/v3.19-next-power-supply-core-ownership
> (actually this is v4: added acks/reviews and minor issue fixed; merge
> window has opened so I'll wait with sending this to LKML).

Great... now you just need one of maintainers to merge it...

POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
M:      Sebastian Reichel <sre@kernel.org>
M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
M:      David Woodhouse <dwmw2@infradead.org>
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
