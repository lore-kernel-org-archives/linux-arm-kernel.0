From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sat, 8 Nov 2014 15:57:01 +0100
Subject: [PATCH] ARM: dts: sun6i: Re-parent ahb1_mux to pll6 as required
 by dma controller
In-Reply-To: <1415275009-415-1-git-send-email-wens@csie.org>
References: <1415275009-415-1-git-send-email-wens@csie.org>
Message-ID: <20141108145701.GZ2989@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 07:56:49PM +0800, Chen-Yu Tsai wrote:
> The dma controller requires that the ahb1 bus clock be driven by pll6
> for peripheral access to work. Previously this was done in the dma
> controller driver, but was since removed as part of a series to unify
> the ahb1_mux and ahb1 clock drivers, in
> 
>     14e0e28 dmaengine: sun6i: Remove obsolete clk muxing code
> 
> Unfortunately the rest of that series did not make it, leaving us with
> broken dma on sun6i.
> 
> This patch reparents ahb1_mux to pll6 using the DT assigned-clocks
> properties in the dma controller node.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
> Hi Maxime,
> 
> This is for 3.18 to fix broken dma. I have verified the clock register
> bits on my A31 Hummingbird. Though I do not have actual hardware to test
> dma peripherals, since this does return things to the way they were, it
> is a proper fix.
> 
> Sorry for the breakage.

Tested and applied, thanks !

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141108/40831afa/attachment.sig>
