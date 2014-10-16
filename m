From: shijie8@gmail.com (Huang Shijie)
Date: Thu, 16 Oct 2014 23:52:52 +0800
Subject: [PATCH v3 0/3] mtd: nand: gpmi: add proper raw access support
In-Reply-To: <EACD232272DA4849B060F0828564D13B44955ABE1F@ntcex01.corp.netcomm.com.au>
References: <1411481256-29141-1-git-send-email-boris.brezillon@free-electrons.com>
 <20141008142437.GA9912@localhost.localdomain>
 <20141008171034.1506550f@bbrezillon>
 <20141010144248.GA5107@localhost.localdomain>
 <EACD232272DA4849B060F0828564D13B44955ABE1F@ntcex01.corp.netcomm.com.au>
Message-ID: <20141016155247.GA2284@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 14, 2014 at 04:50:27PM +1100, Iwo Mergler wrote:
> 
> >
> > No, it doesn't seem to be correct.
> > But it's an MLC flash, so you'll most probably need to apply this patch
> > to nandbiterrs testsuite:
> >
> > http://code.bulix.org/f69wuu-87021
> >
> > This patch is flashing the block between each bitflip insertion to
> > avoid multiple write without erasure (which, AFAIK, is not supported
> > by MLC flashes).
> 
> Hi Huang,
> 
> 
> just out of interest, have you tried this on the MLC NAND without the patch?

yes. I tried. As i posted, it will failed.

> 
> I'm aware that MLC says you shouldn't write multiple times, but that is
> with a view towards specified data endurance. I would only expect a few
> additional bit errors during the test.
> 
> Did you try the overwrite test?
not yet. I can test it tomorrow.

> 
> I'm curious how MLC NAND does when subjected to multiple writes.
We should not do the multiple writes to the MLC nand. 
We can do so with the SLC nand.

thank
Huang Shijie
