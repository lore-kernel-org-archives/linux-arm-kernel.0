From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 03 Mar 2014 12:00:02 +0100
Subject: [PATCH 4/4] ARM: shmobile: r7s72100: use workaround for non
 DT-clocks
In-Reply-To: <20140303092200.GB6531@katana>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <1712106.fu6iC2mT2W@avalon> <20140303092200.GB6531@katana>
Message-ID: <8879891.pRJJJrkMnR@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 03 March 2014 10:22:00 Wolfram Sang wrote:
> On Sun, Mar 02, 2014 at 11:21:40PM +0100, Laurent Pinchart wrote:
> > Hi Wolfram,
> > 
> > Thank you for the patch.
> > 
> > On Friday 28 February 2014 22:09:28 Wolfram Sang wrote:
> > > From: Wolfram Sang <wsa@sang-engineering.com>
> > > 
> > > SCIF2 and MTU2 are not yet prepared for DT usage, so use the common
> > > workaround via clkdev for now.
> > 
> > What about adding a DT node for the serial port instead ? :-)
> 
> Yes, done in V2 already. Yet, I'd like to keep SCIF in here because it
> is the least intrusive way to get the system to boot. When the SCIF
> nodes are added later incrementally, I remove the sh-sci.2 workaround,
> but the whole mechanism is still needed for MTU2 anyhow.

True. I'm working on MTU2 DT support, but that will take a bit more time.

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140303/69234a61/attachment.sig>
