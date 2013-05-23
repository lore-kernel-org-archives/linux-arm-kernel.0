From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 23 May 2013 20:57:26 +0200
Subject: [PATCH 0/4] Marvell PCIe driver improvements
In-Reply-To: <20130523164654.GA31281@obsidianresearch.com>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523001353.GH31625@1wt.eu>
 <20130523164654.GA31281@obsidianresearch.com>
Message-ID: <20130523205726.05ba45bf@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Thu, 23 May 2013 10:46:54 -0600, Jason Gunthorpe wrote:

> > FWIW, these patches applied on top of your pcie-v10 tree have made
> > my mini-pcie dual-nic appear for the first time on the mirabox. Till
> > now I never knew if it was a hardware or software issue since the NIC
> > does not appear in u-boot nor lspci, whatever the kernel versions,
> > including the original Marvell one's. The NIC has two functions (one
> > per controller) and no bridge, so it may be a side effect of your
> > improvements (or maybe you fixed a bug).
> 
> There was some talk earlier that some buggy chips required their
> device number to be 0. I'm guessing Thomas's change to ensure that
> always happens by moving the device number of the internal device is
> the root fix here?

You're correct. Off-list, I've sent to Willy a patch that applies on
top of those additional "bridge-related" fixes, but that reverts back
the slot number of the real PCIe device to be 1 instead of 0. And in
this case, the PCIe device that Willy is using is not detected.

So indeed, there are some PCIe devices who really want to receive
"configuration transactions" as slot 0.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
