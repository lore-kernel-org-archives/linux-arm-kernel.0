From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 17 Jan 2017 10:04:56 +0100
Subject: [PATCH v2 2/4] clk: sunxi-ng: add support for V3s CCU
In-Reply-To: <20170116180116.36729-3-icenowy@aosc.xyz>
References: <20170116180116.36729-2-icenowy@aosc.xyz>
 <20170116180116.36729-3-icenowy@aosc.xyz>
Message-ID: <20170117090456.fgw6lpqgurwwcczj@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 17, 2017 at 02:01:14AM +0800, Icenowy Zheng wrote:
> V3s has a similar but cut-down CCU to H3.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
> ---

Output from checkpatch:
total: 5 errors, 2 warnings, 3 checks, 857 lines checked

> I think I should make a comparsion between V3s and H3 CCU here:
> (I won't mention the missing/added clocks here, only list conflicting clocks)

That should be in your commit log.

> - "bus-ehci0" is at different bit (The bit that is "bus-ehci0" on V3s is
>   "bus-ehci2" on H3)
> - The mux of "ce" is different. (According the view at V3s datasheet by the
>   author of sun4i-ss, V3s may have sun4i-ss, not sun8i-ce)
> - The mux of "de" is different. (V3s do not have "pll-de", but it can mux "de"
>   to "pll-video")
> - Clocks about CSI largely differs. (As V3s is designed as a camera SoC, and
>   it have an extra "pll-isp")

OK.

Thanks,
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170117/0c1f6aeb/attachment.sig>
