From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Nov 2014 20:15:52 +0100
Subject: [PATCH 3/9] clk: sunxi: Add prcm mod0 clock driver
In-Reply-To: <20141127174056.6697cde3@bbrezillon>
References: <54743DE1.7020704@redhat.com> <20141126211318.GN25249@lukather>
 <20141127174056.6697cde3@bbrezillon>
Message-ID: <20141127191552.GS25249@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 05:40:56PM +0100, Boris Brezillon wrote:
> Hi,
> 
> On Wed, 26 Nov 2014 22:13:18 +0100
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> [...]
> 
> > 
> > I remember someone (Chen-Yu? Boris?) saying that the 1wire clock was
> > not really a mod0 clk. From what I could gather from the source code,
> > it seems to have a wider m divider, so we could argue that it should
> > need a new compatible.
> 
> Wasn't me :-).
> 
> Regarding the rest of the discussion I miss some context, but here's
> what I remember decided us to choose the MFD approach for the PRCM
> block:
> 
> 1) it's embedding several unrelated functional blocks (reset, clk, and
> some other things I don't remember).
> 2) none of the functionalities provided by the PRCM were required in
> the early boot stage
> 3) We wanted to represent the HW blocks as they are really described in
> the memory mapping instead of splitting small register chunks over the
> DT.
> 
> Can someone sum-up the current issue you're trying to solve ?

There's (at least) one module0 clock exposed in the PRCM block. We
have a disagreement on whether all module0 clocks should be platform
drivers to support probing that one clock or just to introduce a new
compatible for that one clock in the PRCM alone.

> IMHO, if you really want to split those functionalities over the DT
> (some nodes under clks and other under reset controller), then I
> suggest to use..............
> (Maxime, please stop smiling :P)
> ..............
> 
> SYSCON

We don't really need to share anything, these components are isolated
in separate registers, so syscon doesn't really bring anything here.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/fd9fdb79/attachment.sig>
