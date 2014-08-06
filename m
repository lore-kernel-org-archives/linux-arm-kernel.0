From: jonsmirl@gmail.com (jonsmirl at gmail.com)
Date: Wed, 6 Aug 2014 09:51:05 -0400
Subject: [PATCH 4/9] clk: sunxi: PLL2 support for sun4i, sun5i and sun7i
In-Reply-To: <1406842092-25207-5-git-send-email-emilio@elopez.com.ar>
References: <1406842092-25207-1-git-send-email-emilio@elopez.com.ar>
 <1406842092-25207-5-git-send-email-emilio@elopez.com.ar>
Message-ID: <CAKON4OyBtzD=DhdO_fnCvgr=i+tJ63D9EbAGuCEP93T0UAPv_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 5:28 PM, Emilio L?pez <emilio@elopez.com.ar> wrote:
> +CLK_OF_DECLARE(sun4i_pll2_a, "allwinner,sun4i-a10-a-pll2-clk", sun4i_pll2_setup);
> +CLK_OF_DECLARE(sun4i_pll2_b, "allwinner,sun4i-a10-b-pll2-clk", sun4i_pll2_setup);


This second one should not encode the 'b'.
CLK_OF_DECLARE(sun4i_pll2_b, "allwinner,sun4i-a10-pll2-clk", sun4i_pll2_setup);

The generic DTDs should only contain compatibles that don't have a
chip revision in them.

Then there are two choices:
1) Identify your chip revision and load a DTD with the specific
revisions in the compatible strings.
2) Rely on the OS to identify the revision and modify the compatible at boot.

The strings in the generic DTD should never contain a specific
revision simply because it is unknown in a generic DTD.

> --
> 2.0.3



-- 
Jon Smirl
jonsmirl at gmail.com
