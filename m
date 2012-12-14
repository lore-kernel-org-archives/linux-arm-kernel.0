From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 14 Dec 2012 09:40:12 +0000
Subject: ARM realview breakages w/ 3.7 under qemu
In-Reply-To: <20121213174817.GB12946@mudshark.cambridge.arm.com>
References: <50CA0FC1.5090009@openwrt.org>
 <20121213174817.GB12946@mudshark.cambridge.arm.com>
Message-ID: <20121214094012.GG14363@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 13, 2012 at 05:48:17PM +0000, Will Deacon wrote:
> On Thu, Dec 13, 2012 at 05:26:25PM +0000, Florian Fainelli wrote:
> > - PBX A9: booting with less than 1024MBytes of RAM causes this:
> > [    0.000000] Truncating RAM at 20000000-3fffffff to -3f7fffff (vmalloc 
> > region overlap).
> > [    0.000000] Ignoring RAM at 80000000-8fffffff (vmalloc region overlap).
> > 
> > Do these issues sounds familiar to any of you? The kernel config is 
> > attached in case that helps.

I don't have the original email to reply to (so I don't have the .config
either) but my guess for the above would be that HIGHMEM is disabled.
