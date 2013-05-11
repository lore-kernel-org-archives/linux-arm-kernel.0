From: broonie@kernel.org (Mark Brown)
Date: Sat, 11 May 2013 18:21:32 +0400
Subject: [PATCH RFC] clk: Introduce userspace clock driver
In-Reply-To: <518D7C45.2090602@codeaurora.org>
References: <1368207091-32538-1-git-send-email-soren.brinkmann@xilinx.com>
 <1368207091-32538-2-git-send-email-soren.brinkmann@xilinx.com>
 <518D320C.4010707@elopez.com.ar>
 <fe9e603e-a432-4a29-a195-fd393b875a7e@TX2EHSMHS006.ehs.local>
 <518D411D.9070209@elopez.com.ar>
 <CAPtuhTgsP4gvMAFoQb3icXAZw3ucSg4dfrAdJMho-VxNmNTvwg@mail.gmail.com>
 <518D7C45.2090602@codeaurora.org>
Message-ID: <20130511142132.GA3200@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 10, 2013 at 04:01:25PM -0700, Saravana Kannan wrote:
> On 05/10/2013 03:18 PM, Mike Turquette wrote:

Guys please delete irrelevant context from replies...

> >One way to do it is to introduce a new config option,
> >CONFIG_COMMON_CLK_DEBUG_CONTROL that would expose the controls for
> >every clock in the existing debugfs infrastructure.  The downside to
> >this approach is that it would get abused and ship in millions of
> >Android products using horrible userspace hacks to control clocks.
> >Maybe that's not our problem to solve, maybe it is.

> We already have this for MSM. But I seem to have managed to keep our
> userspace guys away from abusing it. YMMV.

It's much harder when it's in the standard kernel and there's no contact
with some of the users.  I've pushed back pretty strongly on some of
your equivalent stuff for regulators for this reason.

> >I think that Soren wants something with a stable interface that he can
> >use for his Zynq use case.  Regarding that, why not write an actual
> >device driver to do what you want to do from userspace?

> Exposing clock control to userspace production use is a terrible
> idea. A misbehaving userspace can easily kill the system. This is
> not so try for GPIO. So, exposing GPIOs to userspace is relatively
> less of a concern.

Pick the wrong GPIO and you face the same issue.

Note that we do have a UIO framework in place so there is some concept
of doing this sort of thing; that is all about picking specific things
and exposing them (in a somewhat similar fashion to this) rather than a
default available thing though.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130511/bb815d66/attachment.sig>
