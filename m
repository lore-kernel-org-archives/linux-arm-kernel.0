From: broonie@kernel.org (Mark Brown)
Date: Thu, 27 Nov 2014 18:56:41 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <547683A4.4000700@codeaurora.org>
References: <546FC674.1070005@codeaurora.org>
 <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <547526BC.1090202@codeaurora.org>
 <20141126134055.GF7712@sirena.org.uk>
 <547683A4.4000700@codeaurora.org>
Message-ID: <20141127185641.GE7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:51:32PM -0800, Stephen Boyd wrote:
> On 11/26/2014 05:40 AM, Mark Brown wrote:

> >That's what I don't think is making any sense.  Creating two regulators
> >for the same thing seems like bad news, at best it's going to make reuse
> >harder.

> What reuse is harder?

The consumer needs to understand the fact that a given supply might be
represented by multiple different regulators that it sees.  This means
the system integration is not being abstracted away from the consumer.

> >This version is starting to sound a lot like the consumers need to be
> >able to do an idle to sleep transition and change their settings when
> >they enter their sleep mode.  It seems a lot like what many devices do
> >now when they enter and exit runtime PM but with deferred application
> >depending on other users (for regulators I'm assuming the active set
> >would actually be a subset of the sleep set of valid voltages).

> Yes, one key point is that we want the transition to be handled by the RPM
> co-processor. The reason being that usually we want to change settings after
> the last CPU transitions into their sleep mode. There's no way to do this
> without relying on some external co-processor to go and change the settings
> for us.

That all seems like something that can be handled in the RPM driver, it
just needs something to kick it to do the actual writes and let the
consumers proceed as normal.

> >That's not what it seemed like people had been talking about up until
> >this most recent e-mail, you'd been talking about suspend mode.  The
> >starting point was mapping onto the suspend support the regulator has.

> Hm? I've been saying "idle and suspend" each time. Perhaps the initial
> discussion about regulator suspend support threw things off.

I was being asked about use of regulator suspend support, I naively
thought that this might mean the discussion was something about suspend!
It's also not terribly clear to me what the involvement of idle is here.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/a56329be/attachment.sig>
