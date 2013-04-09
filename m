From: horms@verge.net.au (Simon Horman)
Date: Tue, 9 Apr 2013 17:32:43 +0900
Subject: [PATCH v2 0/9] Reorganize R8A7779/Marzen USB code
In-Reply-To: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
References: <201304090110.50154.sergei.shtylyov@cogentembedded.com>
Message-ID: <20130409083243.GF18478@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 09, 2013 at 01:10:49AM +0400, Sergei Shtylyov wrote:
> Hello.
> 
>    Here's the set of 9 patches against the Simon Horman's 'renesas.git' repo,
> 'renesas-next-20130405v2' tag.  It was created to fix the shortcomings in the
> R8A7779/Marzen USB platform code and R8A7779 USB common PHY driver, and so
> spans both arch/arm/mach-shmobile/ and drivers/usb/ subtrees (some patches have
> to touch both subtrees). The patches were conceived with the complete
> bisectability goal in mind. The patches have been tested on the Marzen board.
> 
> [1/9] ARM: shmobile: Marzen: move USB EHCI, OHCI, and PHY devices to R8A7779 code
> [2/9] ehci-platform: add pre_setup() method to platform data
> [3/9] ARM: shmobile: R8A7779: setup EHCI internal buffer
> [4/9] rcar-phy: remove EHCI internal buffer setup
> [5/9] ARM: shmobile: R8A7779: remove USB PHY 2nd memory resource
> [6/9] rcar-phy: correct base address
> [7/9] rcar-phy: add platform data
> [8/9] ARM: shmobile: Marzen: pass platform data to USB PHY device
> [9/9] rcar-phy: handle platform data
> 
>    I'm not sure thru which tree this patchset should be merged, however it turns
> out that it's too late now to push it thru Felipe Balbi's USB tree for 3.10 which
> would have been most convenient probably, so maybe the patchset can be merged
> thru Simon's tree with Felipe's and Alan Stern's ACKs. Or perhaps it now should
> be postponed for 3.11...

I feel that it is also too late for v3.10 for my tree.

I am happy to take them through my tree with appropriate acks.
Or, follow acks from Morimoto-san to allow the shmobile portions
to go through a different tree.
