From: horms@verge.net.au (Simon Horman)
Date: Fri, 30 Oct 2015 16:25:47 +0900
Subject: [PATCH v5 2/5] arm64: dts: r8a7795: add EthernetAVB device node
In-Reply-To: <20151030071745.GA31252@verge.net.au>
References: <1444891698-8780-1-git-send-email-horms+renesas@verge.net.au>
 <1444891698-8780-3-git-send-email-horms+renesas@verge.net.au>
 <CANqRtoQLXQENVxvpMB_pymu7B+F6MhL0CBqPC4EscFTxOYt07Q@mail.gmail.com>
 <20151030071745.GA31252@verge.net.au>
Message-ID: <20151030072546.GC31252@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2015 at 04:17:46PM +0900, Simon Horman wrote:
> On Thu, Oct 29, 2015 at 05:42:43PM +0900, Magnus Damm wrote:
> > On Thu, Oct 15, 2015 at 3:48 PM, Simon Horman
> > <horms+renesas@verge.net.au> wrote:
> > > From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > >
> > > Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> > > [horms: minor updates]
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > > Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> [snip]
> 
> > Hi Simon,
> > 
> > Thanks for your efforts with the ethernet controller. In general all
> > seems good to me, but this I came across the contents of this patch
> > when I was browsing the SoC DTSI file. What is the reason to put this
> > node in between dmac0 and dmac1? I don't know where is the best
> > location, but it would be good to keep the dmac nodes together I
> > think.
> 
> I think its just an artifact of the way the patch has been updated.
> I'll see about cleaning it up.

On slightly closer inspection it seems to be there due to sorting
by base address. But it seems rather silly the way it is so I have it
in mind to shuffle it down below the dmac nodes.
