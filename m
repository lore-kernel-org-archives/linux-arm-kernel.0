From: broonie@kernel.org (Mark Brown)
Date: Tue, 9 Dec 2014 18:16:52 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141208205502.GC3268@sonymobile.com>
References: <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
 <20141208193935.GD11764@sirena.org.uk>
 <20141208205502.GC3268@sonymobile.com>
Message-ID: <20141209181652.GG11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 12:55:03PM -0800, Bjorn Andersson wrote:
> On Mon 08 Dec 11:39 PST 2014, Mark Brown wrote:

> > Now I'm confused again.  I thought entry and exit was all done
> > separately so it was just about saying what should happen if the device
> > were to idle?

> But how do you actually expose that control to the consumers?

I think having an idle state (or possibly just using the suspend state,
I'm still foggy if the two states are actually different) seems to make
sense?

> > That's what should happen, we just don't currently really support doing
> > this configuration dynamically (practically speaking I suspect anyone
> > who cares just doesn't have a suspend mode for affected regulators at
> > the minute).

> What would such configuration look like?

> In the suspend case you could introduce an api for setting parameters of the
> suspend state, but that means that the individual drivers needs to be written
> with awareness of the system state. Our proposal is to use the same api, but
> with a different regulator*, but how should that acquired (and expressed in dt).

We already have an API for the suspend state, we just don't enable its
use in DT yet other than static configuration.  I'm not sure I see the
connection to the system state in the consumer API here - I thought this
was pretty much just setting the state when the device is turned off
which seems device specific?

> In our case, as most things change the both state (or active only if no
> both/sleep), the standard regulator api would have to affect the both state.
> Would we then have a separate api to modify the active state?

Why would we need to introduce a new API for the active state?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141209/4bc5766f/attachment.sig>
