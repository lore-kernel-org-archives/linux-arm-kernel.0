From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 29 Jul 2013 11:29:52 -0600
Subject: [Ksummit-2013-discuss] Defining schemas for Device Tree
In-Reply-To: <20130729172339.GT29916@titan.lakedaemon.net>
References: <2469263.vMN09Q7Tzi@flatron>
 <20130729150124.GS29916@titan.lakedaemon.net>
 <20130729164905.GB2280@localhost.localdomain>
 <20130729172339.GT29916@titan.lakedaemon.net>
Message-ID: <20130729172952.GA1884@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 29, 2013 at 01:23:39PM -0400, Jason Cooper wrote:

> true, the answer to this problem may be to create a depgraph of the
> nodes based on phandles and child status, then init.  However, if the
> goal is to accelerate boot times, then that should not be calculated
> during each boot, especially since it doesn't likely change from boot to
> boot.

That seems like a really smart idea. dtc could store the startup-order
and dependencies in the dtb someplace and the kernel can just run
through that. Using a combination of declaration order and
topo-phandle sorting would probably cover all cases???

Jason
