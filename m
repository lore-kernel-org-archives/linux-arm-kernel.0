From: horms@verge.net.au (Simon Horman)
Date: Tue, 20 Dec 2016 11:54:25 +0100
Subject: [PATCH resend] arm64: dts: r8a7796: salvator-x: Update memory
 node to 4 GiB map
In-Reply-To: <1481815889-15583-1-git-send-email-geert+renesas@glider.be>
References: <1481815889-15583-1-git-send-email-geert+renesas@glider.be>
Message-ID: <20161220105424.GK19532@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 15, 2016 at 04:31:29PM +0100, Geert Uytterhoeven wrote:
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> This patch updates memory region:
> 
>   - After changes, the new map of the Salvator-X board on R8A7796 SoC
>     Bank0: 2GiB RAM : 0x000048000000 -> 0x000bfffffff
>     Bank1: 2GiB RAM : 0x000600000000 -> 0x0067fffffff
> 
>   - Before changes, the old map looked like this:
>     Bank0: 2GiB RAM : 0x000048000000 -> 0x000bfffffff
> 
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [geert: Correct size of old map]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Simon, please apply!
> 
> U-Boot already adds the second memory region to the "reg" property of
> the first memory node in DT, so this patch is actually a no-op.
> IMHO it doesn't make much sense to keep on pretending we don't have
> enabled memory outside the 32-bit address space.

Hi Geert,

I agree with the reasoning above and have queued up this patch for v4.11.

It is a shame that u-boot has enabled this for us as it would have
been nice to retain control of that occuring. But alas it was not to be so.
