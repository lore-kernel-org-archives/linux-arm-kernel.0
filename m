From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Mon, 14 Nov 2016 21:35:37 -0700
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
 <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
Message-ID: <20161115043537.GA23253@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 13, 2016 at 10:02:00PM -0600, atull wrote:
> > I'd add a newop 'write_fragment' and a driver must define write_sg
> > write_fragment, if write_fragment is used then the core supplies
> > that loop.
> 
> Sure, but isn't that just the old op? :)

I'm fine with that too, but it is semantically different since write
is called multiple times in this new world.. All the drivers seem fine
with that today so it is probably OK ..

> There may also be common code that you added to configure_init
> that should go in the core unless it's fpga-specific.

Sure, the alignment test is easy enough to pull out..

Jason
