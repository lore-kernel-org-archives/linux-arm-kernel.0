From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 20 Jan 2014 23:52:20 +0100
Subject: [PATCH] ARM: shmobile: compile drivers/sh for
 CONFIG_ARCH_SHMOBILE_MULTI
In-Reply-To: <20140120155643.GQ17314@sirena.org.uk>
References: <1389707776-23306-1-git-send-email-ben.dooks@codethink.co.uk>
 <1482392.XFeYNLvUZH@avalon> <20140120155643.GQ17314@sirena.org.uk>
Message-ID: <1566590.zu3Q3sqakp@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Monday 20 January 2014 15:56:43 Mark Brown wrote:
> On Mon, Jan 20, 2014 at 04:48:10PM +0100, Laurent Pinchart wrote:
> > The problem isn't as simple as it seems, and more advanced implementations
> > that would allow listing clocks that should be managed automatically (or
> > the other way around) would also add another level of complexity. The
> > required information is platform-dependent, but we currently don't
> > express it as such in DT.
> 
> Well, the set of clocks an IP requires will tend to be the same - it's
> normally just that integrators may have done things like tie them together
> or decide to spread confusion by renaming them.

That's the problem :-) How should the runtime PM core be given the list of 
clocks it needs to manage ? That information needs to come from somewhere.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140120/a2303b43/attachment.sig>
