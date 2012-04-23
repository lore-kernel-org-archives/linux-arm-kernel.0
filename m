From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 23 Apr 2012 16:22:02 -0700
Subject: [PATCH 3/8] clk: mxs: add clock support for imx28
In-Reply-To: <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
References: <1335023840-1394-1-git-send-email-shawn.guo@linaro.org>
 <1335023840-1394-4-git-send-email-shawn.guo@linaro.org>
Message-ID: <CAJOA=zP6VGVX_XHQXFMHWyVasz9npXTTRZYd=WCir-t1Li08bw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 21, 2012 at 8:57 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> Add imx28 clock support based on common clk framework.
>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
...
> +int __init mx28_clocks_init(void)
> +{
> + ? ? ? struct clk *clk;
> + ? ? ? int ret;
> +
> + ? ? ? clk_misc_init();
> +
> + ? ? ? mxs_clk_fixed("ref_xtal", 24000000);

Hi Shawn,

My comment here is the same as patch 2/8.  There is zero
error handling here.  Registration functions _should_ be returning
-EERROR.

Regards,
Mike
