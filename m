From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Thu, 23 May 2013 10:46:54 -0600
Subject: [PATCH 0/4] Marvell PCIe driver improvements
In-Reply-To: <20130523001353.GH31625@1wt.eu>
References: <1369228358-32580-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130523001353.GH31625@1wt.eu>
Message-ID: <20130523164654.GA31281@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 02:13:53AM +0200, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Wed, May 22, 2013 at 03:12:34PM +0200, Thomas Petazzoni wrote:
> > Bjorn, Jason, Andrew, Gregory,
> > 
> > You'll find in this patch series 4 small patches that make various
> > improvements to the Marvell PCIe driver.
> (...)
> 
> FWIW, these patches applied on top of your pcie-v10 tree have made
> my mini-pcie dual-nic appear for the first time on the mirabox. Till
> now I never knew if it was a hardware or software issue since the NIC
> does not appear in u-boot nor lspci, whatever the kernel versions,
> including the original Marvell one's. The NIC has two functions (one
> per controller) and no bridge, so it may be a side effect of your
> improvements (or maybe you fixed a bug).

There was some talk earlier that some buggy chips required their
device number to be 0. I'm guessing Thomas's change to ensure that
always happens by moving the device number of the internal device is
the root fix here?

Regards,
Jason
