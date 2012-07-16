From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 16 Jul 2012 09:52:14 +0200
Subject: [PATCH v2 00/15] PCI io.h clean-up
In-Reply-To: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
References: <1342231451-28861-1-git-send-email-robherring2@gmail.com>
Message-ID: <20120716075214.GA2489@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 09:03:56PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This is the 2nd part of mach/io.h removals. This series removes io.h on
> platforms with PCI by creating a fixed virtual I/O mapping and a common
> __io() macro.

Hi Rob

Time to show my ignorance of PCI again.

root at orion5x:~# cat /proc/ioports 
00001000-0000ffff : PCI0 I/O
00010000-0001ffff : PCI1 I/O

The changes you made for Orion decreased the window to 64K. However, i
see here that PCI0 only gets 60K, where as PCI1 gets the full 64K.

Is this asymmetry correct?

I see this for both orion5x and kirkwood.

   Thanks
	Andrew
