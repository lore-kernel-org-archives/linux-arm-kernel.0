From: broonie@kernel.org (Mark Brown)
Date: Wed, 13 May 2015 12:54:22 +0100
Subject: [PATCH V4 1/3] OPP: Redefine bindings to overcome shortcomings
In-Reply-To: <55525B29.2080307@ti.com>
References: <20150507110233.GR15510@sirena.org.uk>
 <20150507211855.GA2455@codeaurora.org>
 <20150507221842.GW22845@sirena.org.uk>
 <CAKohpomU8wm0T=A7EkosdOjXbP8q2Cb726Hsjh08KTKYjoz3-A@mail.gmail.com>
 <555000B6.2010107@ti.com> <20150512052033.GC32300@linux>
 <20150512190134.16410.89041@quantum> <5552510B.9010306@ti.com>
 <20150512194134.GC3066@sirena.org.uk> <55525B29.2080307@ti.com>
Message-ID: <20150513115422.GQ3066@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 02:57:29PM -0500, Nishanth Menon wrote:
> On 05/12/2015 02:41 PM, Mark Brown wrote:
> > On Tue, May 12, 2015 at 02:14:19PM -0500, Nishanth Menon wrote:

> > specifying the currents involved.  For plausible applications these are
> > likely to be ballpark figures rather than anything too accurate - if
> > nothing else the instantaneous current draw normally varies very
> > substantially so realistically you're talking about a maximum here.  If
> > the corners vary that dramatically then I'd expect you'd see different
> > OPP tables being used anyway.

> OK - If we state "worst case", then it is quantifiable (if SoC vendors
> would like to expose such information - I doubt mine ever will ;) ).
> - We might be able to quantify it better by stating worst case(under
> maximum load) steady state current (to avoid including transient
> spikes which are never representative) at ambient temperature(25C).

Qualcomm do.  It kind of depends on the system how worst case it needs
to be - it'll depend on the expected performance of both the system and
potentially the regulator.  For some systems it may be important to have
some accounting for transients.  Equally systems would only need to be
as accurate as the underlying hardware was able to make use of.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150513/77723d3f/attachment.sig>
