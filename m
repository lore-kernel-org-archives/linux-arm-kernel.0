From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 11 Dec 2015 22:00:29 +0800
Subject: [PATCH] ARM: dts: vf610: use reset values for L2 cache latencies
In-Reply-To: <1448935166-2697-1-git-send-email-stefan@agner.ch>
References: <1448935166-2697-1-git-send-email-stefan@agner.ch>
Message-ID: <20151211140029.GI11252@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 30, 2015 at 05:59:26PM -0800, Stefan Agner wrote:
> Linux on Vybrid used several different L2 latencies so far, none
> of them seem to be the right ones. According to the application note
> AN4947 ("Understanding Vybrid Architecture"), the tag portion runs
> on CPU clock and is inside the L2 cache controller, whereas the data
> portion is stored in the external SRAM running on platform clock.
> Hence it is likely that the correct value requires a higher data
> latency then tag latency.
> 
> These are the values which have been used so far:
> - The mainline values:
>   arm,data-latency = <1 1 1>;
>   arm,tag-latency = <2 2 2>;
>   Those values have lead to problems on higher clocks. They look
>   like a poor translation from the reset values (missing +1 offset
>   and a mix up between tag/latency values).
> - The Linux 3.0 (SoC vendor BSP) values (converted to DT notation):
>   arm,data-latency = <4 2 3>
>   arm,tag-latency = <4 2 3>
>   The cache initialization function along with the value matches the
>   i.MX6 code from the same kernel, so it seems that those values have
>   just been copied.
> - The Colibri values:
>   arm,data-latency = <2 1 2>;
>   arm,tag-latency = <3 2 3>;
>   Those were a mix between the values of the Linux 3.0 based BSP and
>   the mainline values above.
> - The SoC Reset values (converted to DT notation):
>   arm,data-latency = <3 3 3>;
>   arm,tag-latency = <2 2 2>;
> 
> So far there is no official statement on what the correct values are.
> See also the related Freescale community thread:
> https://community.freescale.com/message/579785#579785
> 
> For now, the reset values seem to be the best bet. Remove all other
> "bogus" values and use the reset value on vf610.dtsi level.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thanks.
