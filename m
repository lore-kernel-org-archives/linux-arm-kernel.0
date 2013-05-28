From: balbi@ti.com (Felipe Balbi)
Date: Tue, 28 May 2013 19:24:15 +0300
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <Pine.LNX.4.44L0.1305131012090.1389-100000@iolanthe.rowland.org>
References: <1368424303-10629-5-git-send-email-chao.xie@marvell.com>
 <Pine.LNX.4.44L0.1305131012090.1389-100000@iolanthe.rowland.org>
Message-ID: <20130528162415.GA28253@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, May 13, 2013 at 10:13:44AM -0400, Alan Stern wrote:
> On Mon, 13 May 2013, Chao Xie wrote:
> 
> > Originaly, ehci driver will call the callbacks in platform data
> > for PHY initialization and shut down.
> > With PHY driver, it will call the APIs provided by PHY driver
> > for PHY initialization and shutdown. It removes the callbacks
> > in platform data, and at same time it removes one block in the
> > way of enabling device tree for ehci driver.
> 
> I wonder if this is the sort of thing that should be handled in 
> ehci-hcd.c rather than in all the different platform glue drivers.
> 
> Felipe, what do you think?  Are the required actions now sufficiently 
> generic that a single source file can take care of them?

Sorry for the delay, was on business trip and now on vacations. Anyway,
I agree with you. Our PHY layer should be generic enough that it should
be usable by ehci-hcd itself. If we have any missing method, let's add
it generically.

cheers

ps: dropping this from my queue for now.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130528/39627b15/attachment.sig>
