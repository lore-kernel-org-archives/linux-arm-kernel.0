From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 27 Jan 2016 19:08:22 +0100
Subject: [PATCH RFC 04/11] clk: sunxi: factors: Add unregister function
In-Reply-To: <20160127155210.GH4317@lukather>
References: <1453727747-23307-1-git-send-email-wens@csie.org>
 <1453727747-23307-5-git-send-email-wens@csie.org>
 <20160127155210.GH4317@lukather>
Message-ID: <20160127180822.GQ4317@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 27, 2016 at 04:52:10PM +0100, Maxime Ripard wrote:
> On Mon, Jan 25, 2016 at 09:15:40PM +0800, Chen-Yu Tsai wrote:
> > sunxi's factors clk did not have an unregister function. This means
> > multiple structs were leaked whenever a factors clk was unregistered.
> > 
> > Add an unregister function for it. Also keep pointers to the mux and
> > gate structs so they can be freed.
> > 
> > Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> 
> Applied, thanks!
> Maxime

So, yeah, that obviously didn't work, since clk_unregister_composite
wasn't in.

I want to give that as much linux-next coverage as possible, so I
still pulled 3, 5 and 11, replacing the call to
clk_unregister_composite by clk_unregister, adding a todo note on top.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160127/119c44cc/attachment.sig>
