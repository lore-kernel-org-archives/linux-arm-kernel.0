From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat, 05 Jul 2014 13:58:37 +0200
Subject: [PATCH RFC 06/15] drm/armada: move variant initialisation to
 CRTC init
In-Reply-To: <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk>
References: <20140705103724.GN21766@n2100.arm.linux.org.uk>
 <E1X3NMM-0000A5-N5@rmk-PC.arm.linux.org.uk>
Message-ID: <53B7E86D.5040109@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2014 12:38 PM, Russell King wrote:
> Move the variant initialisation entirely to the CRTC init function -
> the variant support is really about the CRTC properties than the whole
> system, and we want to treat each CRTC individually when we support DT.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
[...]
> diff --git a/drivers/gpu/drm/armada/armada_crtc.h b/drivers/gpu/drm/armada/armada_crtc.h
> index 531a9b0bdcfb..3f0e70bb2e9c 100644
> --- a/drivers/gpu/drm/armada/armada_crtc.h
> +++ b/drivers/gpu/drm/armada/armada_crtc.h
> @@ -38,6 +38,7 @@ struct armada_crtc {
>  	unsigned		num;
>  	void __iomem		*base;
>  	struct clk		*clk;
> +	struct clk		*extclk[2];

Russell,

I wonder, if we should rename above array srcclk instead of extclk
while moving it anyway. That way we can use it for the other variant
specific clocks, too.

FWIW, I totally agree the it was the right thing to wait for you
to sort out the dependencies. Good work, great patience.

Sebastian
