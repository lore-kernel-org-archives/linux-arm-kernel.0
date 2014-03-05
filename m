From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 05 Mar 2014 14:59:37 +0100
Subject: [PATCH 3/4] clk: shmobile: add CPG driver for rz-platforms
In-Reply-To: <20140305135431.GA7985@katana>
References: <1393621768-12568-1-git-send-email-wsa@the-dreams.de>
 <2207635.bd10VfTU6U@avalon> <20140305135431.GA7985@katana>
Message-ID: <1460103.hdWs652aMT@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

On Wednesday 05 March 2014 14:54:32 Wolfram Sang wrote:
> > > > While the parent is indeed selected at boot time only, and only one
> > > > parent is thus needed, parent selection could be performed by a DIP
> > > > switch connected to MD_CLK on the board for instance. In that case
> > > > both parents should be available in DT, as selection will be done by
> > > > the kernel at boot time, not at DT compile time.
> > > 
> > > OK, I understand the case. I still wonder about specifying two parents,
> > > though. If a board uses USB_X1, it then has to spefify a dummy EXTAL
> > > clock (or an empty one), just because USB_X1 is enumerated as second
> > > entry?
> > 
> > That's a good question. Mike, would it be possible to support "holes" in
> > the DT clocks lists, like the GPIO DT bindings do ?
> 
> I talked to Magnus and we decided to start with hardcoded EXTAL for now,
> and leave USB_X1 support for in incremental patch when this is actually
> needed.

That's fine with me (although given the low complexity I would probably have 
gone directly to supporting both clocks) as long as we can ensure both forward 
and backward compatibility. Should we give a name to the clock input through 
the clock-names property for that reason ?

> Note that the devkit will most likely be the only board ever with a
> selectable root clock.

Most probably, but that's no reason not to support it :-)

-- 
Regards,

Laurent Pinchart
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 490 bytes
Desc: This is a digitally signed message part.
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140305/c3a5fc7e/attachment.sig>
