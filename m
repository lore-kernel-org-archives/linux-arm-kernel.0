From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 13 Feb 2013 20:51:39 +0100
Subject: Giving special alignment/size constraints to the Linux PCI core?
In-Reply-To: <20130213191204.GA15710@obsidianresearch.com>
References: <20130130120344.GA29490@avionic-0098.mockup.avionic-design.de>
 <201302122305.28467.arnd@arndb.de>
 <20130213003224.GA32535@obsidianresearch.com>
 <201302131853.14617.arnd@arndb.de>
 <20130213191204.GA15710@obsidianresearch.com>
Message-ID: <20130213205139.77c01873@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Gunthorpe,

On Wed, 13 Feb 2013 12:12:04 -0700, Jason Gunthorpe wrote:

> Thomas, what were your test results on your 10 slot system? Did all 10
> P2P bridges appear in lspci? Was there any address space reservation
> for hot plug?

My test system "only" has 6 PCIe slots, so I couldn't test with the
entire 10 possible PCIe interfaces. But 6 PCIe slots is still a good
number :-)

If you look at the cover letter of the PATCHv3, you'll see the output
of lspci -vvv. It shows that I create one PCI-to-PCI bridge for each
PCIe interface, regardless of whether the link is here or not. And for
those where there is nothing behind the bridge, no address space
reservation occurs, so I am not allocating address decoding windows for
those unused PCIe interfaces.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
