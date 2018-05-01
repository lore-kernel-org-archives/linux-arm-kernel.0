From: broonie@kernel.org (Mark Brown)
Date: Wed, 2 May 2018 06:02:58 +0900
Subject: [PATCH v2 2/2] regulator: add QCOM RPMh regulator driver
In-Reply-To: <f98416ac-230c-0362-ed50-a7f92ff283d7@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org>
 <4b45f41996ea3344340e44fab2dc9e487572e209.1523673467.git.collinsd@codeaurora.org>
 <CAD=FV=XKYCDtF93RtYi+dokR2BcT-z6Ex3UjgJ0ia_kF=847eA@mail.gmail.com>
 <4e3353fe-ebb5-46bb-aa58-49ad04c4d9db@codeaurora.org>
 <CAD=FV=W28_exRv+H0MJvPnHWGEeUG=SMKr=UqEKpBzkH44Fzmg@mail.gmail.com>
 <132ab845-52d6-6192-4d8c-5a9c95410688@codeaurora.org>
 <20180424174507.GI22073@sirena.org.uk>
 <20a8f736-2687-f14f-eaa1-2b2c06eed629@codeaurora.org>
 <20180425103136.GB24769@sirena.org.uk>
 <f98416ac-230c-0362-ed50-a7f92ff283d7@codeaurora.org>
Message-ID: <20180501210258.GG2714@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 25, 2018 at 02:04:56PM -0700, David Collins wrote:

> > Using -EAGAIN for "I can't ever read the configuration from this
> > regulator" doesn't seem right - it's not like any number of retries
> > will ever manage to read the value back.

> In this case, the _regulator_get_voltage() call can succeed, but only
> after a voltage is explicitly requested from the framework side.  The

...

> Do you still have reservations about using -EAGAIN for this purpose?  If
> so, which error code would you suggest using?

Yes, that's clearly a problem - -EAGAIN is more for situations where you
can just immediately retry like signal interruptions.  If the caller
repetedly sits and tries to read the voltage it'll never succeed unless
something else comes along and sets something.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180502/c3175675/attachment.sig>
