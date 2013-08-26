From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Tue, 27 Aug 2013 01:46:42 +0200
Subject: [PATCH v3 4/5] clk/exynos5420: add hdmi mux to change parents in
 hdmi driver
In-Reply-To: <1377508383-15185-5-git-send-email-rahul.sharma@samsung.com>
References: <1377508383-15185-1-git-send-email-rahul.sharma@samsung.com>
 <1377508383-15185-5-git-send-email-rahul.sharma@samsung.com>
Message-ID: <1919681.jqCQjHmyQW@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rahul,

On Monday 26 of August 2013 14:43:02 Rahul Sharma wrote:
> hdmi driver needs to change the parent of hdmi clock
> to pixel clock or hdmiphy clock, based on the stability
> of hdmiphy. This patch is exposing the mux for changing
> the parent.
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
> 5758a69..6f16aa8 100644
> --- a/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> +++ b/Documentation/devicetree/bindings/clock/exynos5420-clock.txt
> @@ -182,6 +182,11 @@ clock which they consume.
>    g3d			501
>    smmu_mixer		502
> 
> +  Mux			ID
> +  ----------------------------
> +
> +  mout_hdmi		1024

Is there a need for such big hole between smm_mixer and this clock? I 
believe that based on the documentation, the total amount of clocks that 
can be defined may be approximated and some extra margin added, so you 
don't waste so much of numbering space and memory used for lookup array.

Best regards,
Tomasz
