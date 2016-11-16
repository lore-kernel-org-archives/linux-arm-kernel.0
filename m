From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 15 Nov 2016 22:20:33 -0700
Subject: [PATCH fpga 8/9] fpga socfpga: Use the scatterlist interface
In-Reply-To: <alpine.DEB.2.20.1611150940270.3634@atull-VirtualBox2>
References: <1478732303-13718-1-git-send-email-jgunthorpe@obsidianresearch.com>
 <1478732303-13718-9-git-send-email-jgunthorpe@obsidianresearch.com>
 <alpine.DEB.2.10.1611131712210.2735@atull-VirtualBox>
 <20161114001854.GA27248@obsidianresearch.com>
 <alpine.DEB.2.10.1611132149140.2908@atull-VirtualBox>
 <20161115043537.GA23253@obsidianresearch.com>
 <alpine.DEB.2.20.1611150940270.3634@atull-VirtualBox2>
Message-ID: <20161116052033.GA6044@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 15, 2016 at 09:47:05AM -0600, atull wrote:
> Not different.
> 
> From 'fpga-mgr.txt':
>   The programming sequence is:
>    1. .write_init
>    2. .write (may be called once or multiple times)
>    3. .write_complete
> 
> The old write was be separate from write_init and write_complete
> because I figured that in the future someone may be streaming in
> the bitstream and not have the whole bitstream in memory.

What is the point of this if write_init gets a copy of the buffer -
what is that supposed to be?

If you see things this way why are you opposed to patch 9? I'll change
things around to call write multiple times and force the sg list into
write_init, which seems like what you intended anyhow..

Jason
