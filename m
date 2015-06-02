From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Tue, 02 Jun 2015 12:26:48 +0300
Subject: [PATCH V2 1/1] ARM: dts: imx7d: add cortex-a7 coresight component
In-Reply-To: <1433192081-1131-1-git-send-email-Frank.Li@freescale.com>
References: <1433192081-1131-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <1433237208.6844.22.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi, 

On Tue, 2015-06-02 at 04:54 +0800, Frank.Li at freescale.com wrote:
> 
> +
> +???????etm at 3007d000 {
> +               compatible = "arm,coresight-etm3x", "arm,primecell";
> +               reg = <0x3007d000 0x1000>;
> +
> +               /* System will hang if added nosmp in kernel command line
> +                       * without arm,primecell-periphid because amba bus try to
> +                       * read id and core1 power off at this time.
> +                       */
> +               arm,primecell-periphid =  <0xbb956>;

I do have similar problem, but in my case it is APB clock which is
missing during device creation time. And I don't know how to fix it.

Adding Russell King as he's the maintainer of the arm,primecell bus.

> +               cpu = <&cpu1>;
> +               clocks = <&clks IMX7D_MAIN_AXI_ROOT_CLK>;
> +               clock-names = "apb_pclk";

Regards,
Ivan
