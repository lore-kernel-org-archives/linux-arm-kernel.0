From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 13 Aug 2013 09:42:28 -0600
Subject: [PATCH V4 1/4] ASoC: Samsung: I2S: Add quirks as driver data
 in I2S
In-Reply-To: <20130812234603.GM6427@sirena.org.uk>
References: <1376300994-1679-1-git-send-email-padma.v@samsung.com>
 <1376300994-1679-2-git-send-email-padma.v@samsung.com>
 <52096871.4030703@wwwdotorg.org> <20130812231327.GK6427@sirena.org.uk>
 <52096D4A.5070903@wwwdotorg.org> <20130812234603.GM6427@sirena.org.uk>
Message-ID: <520A53E4.309@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/12/2013 05:46 PM, Mark Brown wrote:
> On Mon, Aug 12, 2013 at 05:18:34PM -0600, Stephen Warren wrote:
>> On 08/12/2013 05:13 PM, Mark Brown wrote:
> 
>>>> (although I dare say that at least samsung,supports-rstclr
>>>> should be modified to use the new reset controller bindings)
> 
>>> Really?  That doesn't seem terribly sane - I had thought that
>>> was for bodging resets on the side of things that don't
>>> normally have them or need board specific logic.  Also note
>>> that this is actually a magic register write done to reset the
>>> IP on some specific IPs.
> 
>> I believe that's exactly what the reset subsystem and associated
>> DT bindings were designed for.
> 
> That seems...  interesting.  It seems like this is fairly core
> device functionality I'd expect the driver to just be able to
> understand;  the main thing this property was doing was deciding if
> the reset was needed. I'm not sure I see the benefit here?

Sorry, I'm confused here. In this case, the reset is something
internal to the IP module, not sourced by an external reset
controller, so there's no need to involve the reset controller
bindings or subsystem.
