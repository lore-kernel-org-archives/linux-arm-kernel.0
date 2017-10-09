From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 9 Oct 2017 08:54:51 +0200
Subject: [PATCH v2 5/7] PCI: aardvark: disable LOS state by default
In-Reply-To: <20171005174607.GS25517@bhelgaas-glaptop.roam.corp.google.com>
References: <20170928125838.11887-1-thomas.petazzoni@free-electrons.com>
 <20170928125838.11887-6-thomas.petazzoni@free-electrons.com>
 <20171005174607.GS25517@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20171009085451.5a6cfbcc@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 5 Oct 2017 12:46:07 -0500, Bjorn Helgaas wrote:

> On Thu, Sep 28, 2017 at 02:58:36PM +0200, Thomas Petazzoni wrote:
> > From: Victor Gu <xigu@marvell.com>
> > 
> > Some PCIe devices do not support LOS, and will cause timeouts if the
> > root complex forces the LOS state. This patch disables the LOS state
> > by default.  
> 
> Per PCIe r3.1, sec 5.4.1.3, software should not enable L0s in either
> direction unless both ends support L0s.
> 
> I'm unclear on what the bug is here.  Is the generic ASPM code
> incorrectly enabling L0s when one end doesn't support it?  That seems
> unlikely, but if so, it should be fixed in the generic ASPM code.
> 
> Are both ends advertising L0s support, but there's a hardware erratum
> on the Aardvark end that keeps it from working correctly?  If so, we
> should say that explicitly and include a reference to a published
> hardware erratum.
> 
> Something else?

I'll do some more research on this and get back to you.

> > This is part of fixing bug
> > https://bugzilla.kernel.org/show_bug.cgi?id=196339, this commit was
> > reported as the user to be important to get a Intel 7260 mini-PCIe
> > WiFi card working.  
> 
> The bugzilla link is a good start, but "reported by the user to be
> important" is meaningless by itself.  What we need here is the details
> of what's broken and how this fixes it.  Unfortunately the bugzilla
> doesn't have those details.

Yes, the issue is that the bug report doesn't have much details, and I
don't have the specific PCIe card that was used by the bug reporter.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
