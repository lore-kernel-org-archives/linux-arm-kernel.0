From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Oct 2013 10:45:49 -0700
Subject: [PATCHv7][ 2/5] ASoC: eukrea-tlv320: Add DT support.
In-Reply-To: <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
References: <1382616832-23593-2-git-send-email-denis@eukrea.com>
 <20131025191513.5345BC4042C@trevor.secretlab.ca>
 <20131026114840.GX2443@sirena.org.uk>
 <CAHCPf3vHWt5XJCwvGDMfX9rTPKqHU43SHORqpxLtLaDL6RGb8A@mail.gmail.com>
 <20131029174445.GB20251@sirena.org.uk>
 <CAHCPf3sm9BawgCKrPH_mbD-Mhb-uXzSyZTjxhJf1W25pG3wZUA@mail.gmail.com>
 <20131030212927.GM2493@sirena.org.uk>
 <CAHCPf3s46E=s85ohfqajr-VbavAM+gernXkkYeSwd4NYN8AEHw@mail.gmail.com>
 <20131031012830.GZ2493@sirena.org.uk>
 <CAHCPf3vUvg6w-OYO5yM8wj1Gr3p0xQZ=+bZ29ZKrZiQGAYektA@mail.gmail.com>
Message-ID: <20131031174549.GG2493@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 10:32:00AM -0500, Matt Sealey wrote:
> On Wed, Oct 30, 2013 at 8:28 PM, Mark Brown <broonie@kernel.org> wrote:

> > Please consider prioritising this over writing e-mails; talking about
> > device tree does often seem more popular than solving the harder
> > problems.

> If it doesn't get talked about, what happens is people copy paste crap

...

> like writing any because it mostly already exists. Device trees aren't
> something that appeared a year and a half ago and are new
> technology.).

These empty discussions aren't anything new either.  If we just keep on
endlessly going through the basics over and over again without any
associated code this just reinforces the perception that people are more
focused on talking than on actually accomplishing anything.  Lengthy
reiterations of design discussions won't move things forwards.

This is why I keep asking you to review and engage with the prior
discussion or to do concrete things to improve the situation.

> Why some of those internal names don't match the manuals despite the
> binding saying they do. It's because if you go through history of the

Do you see any specific issues here?  It sounds like you're perfectly
aware of what the bindings are supposed to be doing with routing signals
to and from CODECs and have found some errors but you haven't told us
what those are.

Like I keep saying, do concrete things to move things forwards.

> All of which exist here. There are levels of indirection for a good
> reason, I understand that, but in this implementation
> card->set_bias_level calls functions which do purely codec-level
> operations (set fll/mclk/sysclk), codec->set_bias_level does it's
> obviously purely codec-level operations, and then
> card->set_bias_level_post finishes up by doing some, again,
> codec-level operations.

To repeat myself yet again: what is done to the CODEC here is system
dependent.  This includes interaction with other components in the
system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131031/7b9a31a9/attachment.sig>
