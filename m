From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 8 Dec 2014 10:06:36 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <5480CEEF.7000906@codeaurora.org>
References: <20141121232738.GP3815@sirena.org.uk>
 <546FCE3A.1000005@codeaurora.org>
 <20141124181614.GT7712@sirena.org.uk>
 <5473A0F3.6080405@codeaurora.org>
 <20141125204430.GN7712@sirena.org.uk>
 <20141126233447.GD2872@sonymobile.com>
 <20141127190233.GF7712@sirena.org.uk>
 <CAJAp7OgBepNL6j4D6_MvXJ5PTRDUFNt6paskkP=q=h8W_YNP_Q@mail.gmail.com>
 <20141128201613.GB7712@sirena.org.uk>
 <5480CEEF.7000906@codeaurora.org>
Message-ID: <20141208180635.GB3268@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 04 Dec 13:15 PST 2014, Stephen Boyd wrote:

> On 11/28/2014 12:16 PM, Mark Brown wrote:
> > On Thu, Nov 27, 2014 at 11:42:41AM -0800, Bjorn Andersson wrote:

[..]

> >> The exposure of multiple regulators moves the problem to the
> >> devicetree, making sure to map the consumers to the right
> >> state/regulator. But it should only be the cpu (in its various forms)
> >> that ever consume the active only regulator.
> > He said hopefully...  :)

:)

> >
> > I think I now have a reasonable picture of what's going on but wanted to
> > confirm that what I'm saying above makes sense.
> 
> That's good. Is there any conclusion here? I'm still thinking that
> having multiple regulators for the same physical supply is the right
> thing to do.
> 

As I said, the only other idea I've come up with will not cut it for the
regulators that need more than enable/disable support when going to sleep.

Even if we came up with some model of exposing something similar to the suspend
state, we would still need to expose it in a way that we can specify which
(active/sleep/both) state in the consumer. Hence in practice we end up with
exposing multiple regulators in one way or another.


I can't help thinking that this would be a problem with the static suspend
settings as well; i.e. what is the static suspend state for a regulator that
powers a WiFi chip? For me the answer would often be "it's enabled iff the WiFi
consumer asks for it" - but maybe it's not supposed to be used for "dynamic"
regulators.


Nontheless, we have reached conclusions regarding my RFC. So I'll move on and
finish up a multi-regulator implementation and we can continue the discussion
based on that.

Regards,
Bjorn
