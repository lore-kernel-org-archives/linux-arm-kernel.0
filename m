From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 7 Nov 2012 11:41:21 +0100
Subject: [Resend PATCH v3 2/4] ARM: at91: atmel-ssc: add device tree
 support
In-Reply-To: <20121107092124.GE12323@opensource.wolfsonmicro.com>
References: <1352259701-19847-1-git-send-email-voice.shen@atmel.com>
 <20121107084932.GE20063@game.jcrosoft.org>
 <20121107092124.GE12323@opensource.wolfsonmicro.com>
Message-ID: <20121107104121.GG20063@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10:21 Wed 07 Nov     , Mark Brown wrote:
> On Wed, Nov 07, 2012 at 09:49:32AM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > yes the pinctrl is mainline in -next via pinctrl tree
> 
> > s code does not work on the DT kernel untill it's done
> 
> > NACK stand I refuse this touch the at91 dtsi untiol it's done correctly
> 
> ...and here's another mail (plus a further private mail on the same
> subject) by the time I managed to reply to the first one, the timestamps
> say in about ten minutes :/  What I'm seeing here is two of the Atmel
> maintainers disagreeing about a patch so I've got to pick one view and
> right now applying the patch looks like it moves us further forwards.
> 
> Like I say it's not an issue right now and it seems like it should be
> trivial to fix.  Is anything needed here other than adding the
> pinctrl_get_set_default() call, in which case would it not be less
> effort all round to just send the patch?  If there is more involved then
> what is needed?
for the driver point of view I agreee with you for the dtsi I disagree I miss
100 lignes of pinctrl description

so today if no pinctrl the pin are input gpio and the drivers will not work

if this code was tested this work MUST have been done otherwise we will apply
non tested work

so dor the dtsi part I do NACK it and the pinctrl code is arropund for 2 or 3
months so no excuse even Joachim who add the rm9200 support to DT handled the
pinctrl so no exeption on at91 when switching to DT the pinctrl is mandatory

If you want to apply the part of the patch that touch only the drivers I'm
fine but for the dtsi no


Best Regards,
J.
> 
> Thinking about it a little more I'm actually wondering why whatever
> pinctrl change made this mandatory didn't go through and update all the
> drivers.
