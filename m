From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 31 Jan 2017 22:05:17 +0100
Subject: [PATCH] rtc: sun6i: Fix compatibility with old DT binding
In-Reply-To: <20170129101343.7222-1-wens@csie.org>
References: <20170129101343.7222-1-wens@csie.org>
Message-ID: <20170131210517.jkhwe3e2d7mjfgti@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29/01/2017 at 18:13:43 +0800, Chen-Yu Tsai wrote:
> Commit 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator") adds
> a new clock for the rtc block with a 2 step probe mechanism. To share
> the register region between both the clock and rtc instance, a static
> pointer is used to keep the related data structure.
> 
> To preserve compatibility with the old binding, the data structure
> should be saved as soon as the registers are mapped in, regardless
> of the presence of the clock bindings, so that the rtc device can
> retrieve it when it is probed.
> 
> This fixes the rtc device not probing when we use the updated driver
> with an old device tree blob.
> 
> Fixes: 847b8bf62eb4 ("rtc: sun6i: Expose the 32kHz oscillator")
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  drivers/rtc/rtc-sun6i.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
