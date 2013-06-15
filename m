From: stern@rowland.harvard.edu (Alan Stern)
Date: Fri, 14 Jun 2013 22:24:09 -0400 (EDT)
Subject: [PATCh V10 04/12] usb: ehci: ehci-mv: use PHY driver for ehci
In-Reply-To: <CADApbehtqANXPBix-h8hngitEKKjEq3SYT1EOihwwg=FtJX3Pw@mail.gmail.com>
Message-ID: <Pine.LNX.4.44L0.1306142221210.9343-100000@netrider.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 14 Jun 2013, Chao Xie wrote:

> I checked with the code in our 3.4 git. we really did a lot of things
> when suspend/resume, and at that point the patch for ehci_resume and
> ehci_suspend are not added.
> i think the driver can make use of ehci_resume/ehci_suspend.
> For PHY, we have to initialize it and shutdown it when do
> suspend/resume. Our PHY do not have any suspend states.
> I suppose these phy operation have to be handled by each ehci driver
> owner only, or you think it can be handled at ehci-hce level?.

If the operations are the same for each platform, then yes -- they 
could be done in ehci-hcd.  But if different platforms handle their 
PHYs differently then each glue module will need to do this on its own.

Alan Stern
