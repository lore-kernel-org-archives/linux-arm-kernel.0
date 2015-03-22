From: broonie@kernel.org (Mark Brown)
Date: Sun, 22 Mar 2015 18:56:27 +0000
Subject: [PATCH 0/7] OPP: Introduce OPP bindings V2 and supporting code
In-Reply-To: <CAKohpo=uJJw0=T+yfV=aAUQq+Z2-kZFJWFqxnN6B8QtSb2XHqg@mail.gmail.com>
References: <cover.1423642246.git.viresh.kumar@linaro.org>
 <20150212005220.GG11190@codeaurora.org>
 <CAKohponaLt51hiHd=uTocK_fPPwRDgkse5wc_PGG5tFQNnvfAQ@mail.gmail.com>
 <20150212082004.GJ11190@codeaurora.org>
 <CAKohpo=uJJw0=T+yfV=aAUQq+Z2-kZFJWFqxnN6B8QtSb2XHqg@mail.gmail.com>
Message-ID: <20150322185627.GI6643@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 17, 2015 at 01:16:25PM +0530, Viresh Kumar wrote:
> On 12 February 2015 at 16:20, Stephen Boyd <sboyd@codeaurora.org> wrote:

> > voltages. I suppose something like opp-microvolt-names would work
> > though but I don't know how software would correlate that to the
> > regulator it uses because that information is elsewhere in the

> I hope the CPU node will have an array of supplies to support multiple
> regulators, right? If yes, then we can just keep the array of <t/min/max>
> in the same order. And software should be able to correlate then?

It's probably not *too* bad for small numbers of supplies but bindings
that require that indexes into two different arrays match up
(particularly with different step sizes as here) do have legibility
issues - it's easy to miscount when reading things.

> > device's node. Why not put the information about which clock and
> > regulator is used into the opp node?

> Don't know. I have been asked specifically to keem them out of the OPPs,
> as they belong to the CPU or device instead.

The DT should describe the hardware and how it's connected.  No power
supplies or clocks are connected to an OPP, an OPP is a property of
something else.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150322/dac50316/attachment.sig>
