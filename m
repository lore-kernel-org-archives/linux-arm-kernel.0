From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 09 Apr 2014 11:16:07 +0200
Subject: [PATCH 3/3] ARM: socfpga: dts: add reset-controller
In-Reply-To: <73mwfu3nly.fsf@unicorn.hi.pengutronix.de>
References: <1396629087-23727-1-git-send-email-s.trumtrar@pengutronix.de>
 <1396629087-23727-4-git-send-email-s.trumtrar@pengutronix.de>
 <1396905121.25236.2.camel@linux-builds1>
 <20140407224110.GA28399@pengutronix.de> <53435F37.7060301@gmail.com>
 <73mwfu3nly.fsf@unicorn.hi.pengutronix.de>
Message-ID: <1397034967.4418.4.camel@paszta.hi.pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, den 09.04.2014, 10:37 +0200 schrieb Steffen Trumtrar:
> Dinh Nguyen <dinh.linux@gmail.com> writes:
> 
> > On 4/7/14 5:41 PM, Steffen Trumtrar wrote:
> >> On Mon, Apr 07, 2014 at 04:12:01PM -0500, Dinh Nguyen wrote:
> >>> On Fri, 2014-04-04 at 18:31 +0200, Steffen Trumtrar wrote:
> >>>> Add the necessary #reset-cells property to the rst-mgr node and
> >>>> provide a header-file with all possible resets specified.
> >>>>
> >>>> Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> >>>> ---
> >>>>  arch/arm/boot/dts/socfpga.dtsi           |  8 ++-
> >>>>  include/dt-bindings/reset/altr,rst-mgr.h | 90 ++++++++++++++++++++++++++++++++
> >>> Does this file belong under dt-bindings/reset/ or
> >>> dt-bindings/reset-controller/?
> >>>
> >> ATM there is no such directory, or is there ?
> >> So, reset seems appropriate I think.
> > commit [6b7f06 ARM: STi: STiH415: Add reset controller support.]
> > Seems more appropriate for this to go into reset-controller.
> >
> 
> Okay, the current mainline master now has include/dt-bindings/reset and
> include/dt-bindings/reset-controller.
> 
> I think one of those directories shouldn't be there, but be merged in
> the other instead. But which one? Where shall I put my precious code?

My vote would be for dt-bindings/reset/, since that's shorter and
2ec941304df9e1cd5e2f2404303a5fab0929969a came before
6b7f06cc805bb4755e69cd916b3f565947e0a77a.

Maybe something also should be done about dt-bindings/clk/ and
dt-bindings/clock/.

regards
Philipp
