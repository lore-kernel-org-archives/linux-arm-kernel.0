From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 27 Aug 2013 01:49:29 +0200
Subject: [PATCH v3 5/5] clk/exynos5420: assign dout_pixel id to pixel
 clock divider
In-Reply-To: <1377508383-15185-6-git-send-email-rahul.sharma@samsung.com>
References: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
 <1377508383-15185-6-git-send-email-rahul.sharma@samsung.com>
Message-ID: <2957212.KZ8HRQb1uk@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On Monday 26 of August 2013 14:43:03 Rahul Sharma wrote:
> dout_pixel is a new ID allocated for pixel clock divider. It is
> queried in the driver to pass as the parent to hdmi clock while
> switching between parents.
> 
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> ---
>  Documentation/devicetree/bindings/clock/exynos5420-clock.txt |    5
> +++++ drivers/clk/samsung/clk-exynos5420.c                         |   
> 5 ++++- 2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git
> a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt index
> 6f16aa8..4c069bd 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> @@ -187,6 +187,11 @@ clock which they consume.
> 
>    mout_hdmi		1024
> 
> +  Divider		ID
> +  ----------------------------
> +
> +  dout_pixel		2048

That's an even bigger hole.

Could you check in the documentation how many muxes are present in the 
clock controller of Exynos5420, add some margin (presumably rounding up to 
some nice value, not necessarily to a power of two) and calculate a more 
reasonable start value for dividers?

Best regards,
Tomasz'
