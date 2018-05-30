From: broonie@kernel.org (Mark Brown)
Date: Wed, 30 May 2018 17:20:07 +0100
Subject: [PATCH v4 1/2] regulator: dt-bindings: add QCOM RPMh regulator
 bindings
In-Reply-To: <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
References: <cover.1527040878.git.collinsd@codeaurora.org>
 <6d03576cf90f06afb1194301cb41fc31704def1d.1527040878.git.collinsd@codeaurora.org>
 <CAD=FV=VH0bTxPOmRr+jUyV0cGNQHLcwQTV9L-t0bxZOqD8FnHA@mail.gmail.com>
 <20180530103720.GH6920@sirena.org.uk>
 <CAD=FV=WTTKXwPchuWRh-RNTc8=X8Xo28oTqk=3wW4+SiTHhxuA@mail.gmail.com>
 <20180530155044.GR6920@sirena.org.uk>
 <CAD=FV=WVUmvPPd5BxXv9Sa_2CRPrrjQvYFyqroY-3fRr4f0Bzg@mail.gmail.com>
Message-ID: <20180530162007.GU6920@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 30, 2018 at 09:12:25AM -0700, Doug Anderson wrote:
> On Wed, May 30, 2018 at 8:50 AM, Mark Brown <broonie@kernel.org> wrote:

> > No, I'm saying that I don't know why that property exists at all.  This
> > sounds like it's intended to be the amount of current the regulator can
> > deliver in each mode which is normally a design property of the silicon.

> Ah, got it.  So the whole point here is to be able to implement either
> the function "set_load" or the function "get_optimum_mode".  We need
> some sort of table to convert from current to mode.  That's what this
> table does.

We do need that table, my expectation would be that this table would be
in the driver as it's not something I'd expect to vary between different
systems but rather be a property of the silicon design.  No sense in
every single board having to copy it in.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180530/e99e0527/attachment-0001.sig>
