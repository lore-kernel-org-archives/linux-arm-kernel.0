From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 7 Nov 2012 14:05:35 +0000
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107104121.GG20063@game.jcrosoft.org>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
 <20121107104121.GG20063@game.jcrosoft.org>
Message-ID: <20121107140535.GA28954@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 07, 2012 at 11:41:21AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:21 Wed 07 Nov     , Mark Brown wrote:

> > Like I say it's not an issue right now and it seems like it should be
> > trivial to fix.  Is anything needed here other than adding the
> > pinctrl_get_set_default() call, in which case would it not be less
> > effort all round to just send the patch?  If there is more involved then
> > what is needed?

> for the driver point of view I agreee with you for the dtsi I disagree I miss
> 100 lignes of pinctrl description

> so today if no pinctrl the pin are input gpio and the drivers will not work

> if this code was tested this work MUST have been done otherwise we will apply
> non tested work

> so dor the dtsi part I do NACK it and the pinctrl code is arropund for 2 or 3
> months so no excuse even Joachim who add the rm9200 support to DT handled the
> pinctrl so no exeption on at91 when switching to DT the pinctrl is mandatory

> If you want to apply the part of the patch that touch only the drivers I'm
> fine but for the dtsi no

So what the above is saying is that we should have a followup patch to
add the pinctrl setup to the DT (probably one that goes along with the
pinctrl changes and adds complete pinctrl setup for the affected boards
rather than just doing the audio piecemeal) and do the mindless call in
the driver.  That doesn't seem impossible.

So long as we get those things in place prior to the merge window we
should be fine.  Even if we don't manage that it still seems like having
the patch is better than not having it, from the sounds of it the boards
are going to be totally broken if they boot with DT but without the
pinctrl setup and the ASoC bindings are pretty much an orthogonal issue
to that.  Having the bindings for the SSC (which depend on this AFAICT)
will allow other machines which are doing a better job with pinctrl to
work.

Does that seem reasonable?
