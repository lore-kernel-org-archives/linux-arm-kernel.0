From: broonie@kernel.org (Mark Brown)
Date: Mon, 9 Dec 2013 11:27:54 +0000
Subject: [PATCH] ARM: cpu: Document and tweak clock-frequency property
In-Reply-To: <CAFEAcA_GG_GW0ZXbTPMp7M0foK_sjUwYx0kk_YULVn0d9ozosA@mail.gmail.com>
References: <1386331027-26065-1-git-send-email-broonie@kernel.org>
 <52A36AB3.6060102@gmail.com> <20131208161922.GK29268@sirena.org.uk>
 <CAFEAcA8qsb0f_5dVbytCD3fGQdT+W4=PJudCY1f-ee4Pwm=0=Q@mail.gmail.com>
 <20131208192237.GM29268@sirena.org.uk>
 <CAFEAcA9oCPi0dj89NJ0k2wOsbVBCV=3=7FBrn=xuYdouJWc98Q@mail.gmail.com>
 <20131208215026.GO29268@sirena.org.uk>
 <CAFEAcA_GG_GW0ZXbTPMp7M0foK_sjUwYx0kk_YULVn0d9ozosA@mail.gmail.com>
Message-ID: <20131209112754.GQ29268@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 08, 2013 at 10:55:28PM +0000, Peter Maydell wrote:
> On 8 December 2013 21:50, Mark Brown <broonie@kernel.org> wrote:

> > There does come a point where it's just nitpicking and not helpful but
> > if it has a substantial effect on functionality then it's useful.  In
> > this case suppressing the warning for non-asymmetric systems might be
> > sensible.

> Hmm, so "mandatory for non-symmetric [I assume you mean
> that and not really 'non-asymmetric'?], otherwise optional" ?
> I think that would be reasonable and preserve backwards
> compatibility.

No, I really mean asymmetric - I'm talking about the cases where we
suppress the warning.

> > For all practical purposes it is currently optional but the spec says
> > it is mandatory.  I would rather err on the side of not changing the
> > documentation in case someone does work based on ePAPR and/or an old
> > kernel and since doing that keeps the spec more stable even if we do
> > implement in a more tolerant fashion within Linux (as we should).

> As I say, I don't think your specification currently does say
> it is mandatory. If the documentation doesn't clearly list
> it as a mandatory parameter, and a large number of

Like I say I don't think that's a sensible interpretation and that if it
is what we want to do then someone's got to find the time to copy all
the bindings out of the spec into the kernel.

> people writing DTS files or DT generation code haven't
> put it in, and the kernel didn't complain about it not being
> present for a long long time, then de facto it is optional,
> and you should make your documentation conform with reality
> and fix bugs where the kernel isn't coping with that.

The kernel currently copes fine with this, welcome to the world of
writing things down in specifications.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131209/5b2adbd4/attachment.sig>
