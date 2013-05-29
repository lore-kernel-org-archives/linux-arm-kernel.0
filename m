From: balbi@ti.com (Felipe Balbi)
Date: Wed, 29 May 2013 20:37:15 +0300
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <CADApbegejeoxc4TmjvsPse=54durFym2cfDRdg9RviDZJ2HAFg@mail.gmail.com>
References: <1368424303-10629-5-git-send-email-chao.xie@marvell.com>
 <Pine.LNX.4.44L0.1305131012090.1389-100000@iolanthe.rowland.org>
 <20130528162415.GA28253@arwen.pp.htv.fi>
 <CADApbegejeoxc4TmjvsPse=54durFym2cfDRdg9RviDZJ2HAFg@mail.gmail.com>
Message-ID: <20130529173715.GB21290@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 29, 2013 at 11:58:01AM +0800, Chao Xie wrote:
> On Wed, May 29, 2013 at 12:24 AM, Felipe Balbi <balbi@ti.com> wrote:
> > Hi,
> >
> > On Mon, May 13, 2013 at 10:13:44AM -0400, Alan Stern wrote:
> >> On Mon, 13 May 2013, Chao Xie wrote:
> >>
> >> > Originaly, ehci driver will call the callbacks in platform data
> >> > for PHY initialization and shut down.
> >> > With PHY driver, it will call the APIs provided by PHY driver
> >> > for PHY initialization and shutdown. It removes the callbacks
> >> > in platform data, and at same time it removes one block in the
> >> > way of enabling device tree for ehci driver.
> >>
> >> I wonder if this is the sort of thing that should be handled in
> >> ehci-hcd.c rather than in all the different platform glue drivers.
> >>
> >> Felipe, what do you think?  Are the required actions now sufficiently
> >> generic that a single source file can take care of them?
> >
> > Sorry for the delay, was on business trip and now on vacations. Anyway,
> > I agree with you. Our PHY layer should be generic enough that it should
> > be usable by ehci-hcd itself. If we have any missing method, let's add
> > it generically.
> >
> So what are your idea about making the PHY layer more generic? How
> ehci-hcd will make use of PHY layer?


on probe grab the phy and initialize it. On suspend/resume,
suspend/resume the PHY and so on. Whatever you were going to do on your
ehci glue, do it on generic ehci-hcd.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130529/fc3b51af/attachment.sig>
