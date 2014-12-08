From: broonie@kernel.org (Mark Brown)
Date: Mon, 8 Dec 2014 19:39:35 +0000
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141208180635.GB3268@sonymobile.com>
References: <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
 <20141208180635.GB3268@sonymobile.com>
Message-ID: <20141208193935.GD11764@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 10:06:36AM -0800, Bjorn Andersson wrote:
> On Thu 04 Dec 13:15 PST 2014, Stephen Boyd wrote:
> > On 11/28/2014 12:16 PM, Mark Brown wrote:

> > > I think I now have a reasonable picture of what's going on but wanted to
> > > confirm that what I'm saying above makes sense.

> > That's good. Is there any conclusion here? I'm still thinking that
> > having multiple regulators for the same physical supply is the right
> > thing to do.

I'm still not finding it easy to find this tasteful.

> As I said, the only other idea I've come up with will not cut it for the
> regulators that need more than enable/disable support when going to sleep.

> Even if we came up with some model of exposing something similar to the suspend
> state, we would still need to expose it in a way that we can specify which
> (active/sleep/both) state in the consumer. Hence in practice we end up with
> exposing multiple regulators in one way or another.

Now I'm confused again.  I thought entry and exit was all done
separately so it was just about saying what should happen if the device
were to idle?

> I can't help thinking that this would be a problem with the static suspend
> settings as well; i.e. what is the static suspend state for a regulator that
> powers a WiFi chip? For me the answer would often be "it's enabled iff the WiFi
> consumer asks for it" - but maybe it's not supposed to be used for "dynamic"
> regulators.

That's what should happen, we just don't currently really support doing
this configuration dynamically (practically speaking I suspect anyone
who cares just doesn't have a suspend mode for affected regulators at
the minute).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141208/29eb47f8/attachment.sig>
