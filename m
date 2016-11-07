From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 7 Nov 2016 08:54:38 +0100
Subject: [PATCH 1/2] clk: sunxi-ng: Fix CPUX clock for the A23/A33
In-Reply-To: <20161106172932.39478-1-icenowy@aosc.xyz>
References: <20161106172932.39478-1-icenowy@aosc.xyz>
Message-ID: <20161107075438.gjva4r53q25z2ijb@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Nov 07, 2016 at 01:29:31AM +0800, Icenowy Zheng wrote:
> The CPUX clock of A23/33 CCU driver forgot to add CLK_SET_RATE_PARENT
> flag, which makes its frequency fail to change (as part of cpu thermal
> throttle).
> 
> Fix it by add this flag.

Your commit title and log could be better.

The title usually is more about what is done in the patch itself,
something like "clk: sunxi-ng: Allow to change the parent rate for the
CPU clocks" in this case.

And your commit log should explain why it is an issue. Yours is even
wrong here, we could definitely change the rate of these clocks
already. The only thing that was not allowed was to change the rate of
its parents, which is what this patch fixes.

> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---
> Patch 4.9-rc too.

I don't see why it should be part of 4.9. No one uses that code in 4.9.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161107/46d235a8/attachment.sig>
