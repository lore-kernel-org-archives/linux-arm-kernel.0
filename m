From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 04 Sep 2013 12:21:36 -0600
Subject: [alsa-devel] [PATCH 2/3] ASoC: generic simple sound card DT
 bindings
In-Reply-To: <20130903231922.GL3084@sirena.org.uk>
References: <1377945878-13322-1-git-send-email-mpa@pengutronix.de>
 <1377945878-13322-3-git-send-email-mpa@pengutronix.de>
 <52220766.1040504@metafoo.de> <52263795.8010600@wwwdotorg.org>
 <20130903231922.GL3084@sirena.org.uk>
Message-ID: <52277A30.8010102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/03/2013 05:19 PM, Mark Brown wrote:
> On Tue, Sep 03, 2013 at 01:25:09PM -0600, Stephen Warren wrote:
> 
>> Mark has made the argument that (at least for CODEC analog pins)
>> we can simply put those strings into the binding document, and
>> make them as much a part of the binding as anything else. After
>> all, (at least for CODEC analog pins) the values are simply the
>> names of the pins on the package, as listed by the HW
>> documentation itself.
> 
>> We could presumably do the same thing for DAIs; in DT, use a 
>> string-based DAI name derived directly from the HW documentation,
>> rather than the current intra-ASoC DAI name strings.
> 
>> That said, I will admit that I personally don't really like the
>> idea of using strings in bindings. That opinion certainly isn't
>> universal though.
> 
> I think either works - with DAIs there is a tendency (though not 
> universal) for devices to just have numbered interfaces which makes
> the numbers more natural.  I'm more concerned with the binding
> being legible than with what ends up physically written in there,
> the original reason for strings (apart from the fact that they're
> in the drivers already) was that there was a lot of resistance in
> the DT community to symbolic constants.  That would have lead to
> bindings which looked like line noise.

True.

>>> The binding also assumes that a CPU controller may have one DAI
>>> at most. In my opinion this binding ought to use the upcoming
>>> of_xlate stuff for ASoC components.
> 
>> That restriction seems reasonable for a *simple* DT sound
>> binding. For more complex cards, one could presumably create more
>> complex bindings, be they generic bindings that cover arbitrary
>> more complex cases, or bindings for specific configurations that
>> happen to include multiple DAIs.
> 
> The complexity there comes from the device that's being used rather
> than the design of the sound card though - the fact that a SoC has
> an audio block with many DAIs shouldn't prevent it using the simple
> bindings if someone just hung a simple CODEC off one of the DAIs.

Yes, exactly.
