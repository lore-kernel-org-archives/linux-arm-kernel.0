From: matt@genesi-usa.com (Matt Sealey)
Date: Sun, 7 Apr 2013 11:34:14 -0500
Subject: [RFC PATCH] CLK: Allow parent clock and rate to be configured in
 DT.
In-Reply-To: <CAKGA1bnt_wrNPg2JdAu=ac+WiUm8pVaGh3Tjrt3NvgdFeLxB8A@mail.gmail.com>
References: <20130319170933.28337.50448.stgit@localhost>
 <CAOMZO5ASkvquyzPCEGObvB5Xh9bDPTJ2zx26eOUJT_Vb36Bn3Q@mail.gmail.com>
 <CAKGA1bkWLrOs15ni=8D__BvuG6kvqkeeLZGOLrVZY9g0q0z4Bg@mail.gmail.com>
 <6581638.FPkNsv6peb@flatron> <20130407132623.GP1906@pengutronix.de>
 <CAKGA1b=AcQsA-P-pR+in+9CzqW=XfEBhdoR+AC7QCLYfUhQqJg@mail.gmail.com>
 <CAOMZO5ARwOLdSg4Np_HB2m7zvTNE94bJBUh3R-oG=xcP4R6Y-Q@mail.gmail.com>
 <CAKGA1bnt_wrNPg2JdAu=ac+WiUm8pVaGh3Tjrt3NvgdFeLxB8A@mail.gmail.com>
Message-ID: <CAKGA1bnhMz-18RvUq1Bx-b_AztwspYC+Q+3QGYf=kBtMe1nq2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Or actually, let me rephrase that; sure, when we decide that the
actual clock tree is described IN the device tree and not in Linux -
the only thing I have to test this on is i.MX and OMAP and it's all a
huge table in the Linux kernel which the DT uses to reference
arbitrary indices into a provider array...

I could add desired parents to the provider array but that wouldn't
really fix the configuration problem. Can we get an agreement that
actually, no matter how "unwieldy" or "unreadable" some people think
it might be, that the entire clock tree for a board should end up in
it's device tree (muxes, selects, gates and all) with suitable
bindings? This is the only way you'll get clock "hacks" out of the
source.

I do have a kernel tree for some 3.8-rc (which you know of already)
which started work on this and I had some success with it. I'll need a
little while to move it forward after Shawn moved some things around,
rebase all the work.. there are more problems to fix with how
everything "works" right now than just a need for configuration data,
which is why I am so opposed to adding that configuration data. It
supposes that we are giving complete descriptions already anyway, and
my proposal relies on having complete descriptions anyway, when we are
not in either case. Give me a couple weeks and I'll probably have it
done, if nothing moves under my feet again..

At the point where we have two proposals here; implement 100 clocks as
device tree nodes, or implement multiple ways of providing clock
reparenting and frequency setting information as a configuration
clock, I would rather implement those 100 clocks as nodes..
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.


On Sun, Apr 7, 2013 at 11:23 AM, Matt Sealey <matt@genesi-usa.com> wrote:
> On Sun, Apr 7, 2013 at 11:00 AM, Fabio Estevam <festevam@gmail.com> wrote:
>> On Sun, Apr 7, 2013 at 12:50 PM, Matt Sealey <matt@genesi-usa.com> wrote:
>>
>>> If we're dealing with audio codecs, fix the audio codec to accept a
>>> *table* of possible clock values and if that hardware operates
>>> differently per clock value, then add that data in there too (like the
>>> cs42l52 audio codec). Where the software and hardware is a little more
>>> dynamic, the same binding works here - and the usual trick is just
>>> force one configuration possible out of many. The board designer can
>>> look at all the possibilities and choose the one or two or all that
>>> will work with the design, and it can go into the device tree.
>>
>> Sorry, but I have a hard time following a so long response.
>>
>> Can't you just send patches to the list with your proposal so that we
>> can move forward with the idea?
>
> Sure.
>
> --
> Matt Sealey <matt@genesi-usa.com>
> Product Development Analyst, Genesi USA, Inc.
