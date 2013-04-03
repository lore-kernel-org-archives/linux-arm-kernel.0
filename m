From: mturquette@linaro.org (Mike Turquette)
Date: Wed, 03 Apr 2013 14:45:45 -0700
Subject: [PATCH v2 0/6] clk: sunxi: gates support
In-Reply-To: <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
References: <1363962042-29536-1-git-send-email-emilio@elopez.com.ar>
 <1364419243-18446-1-git-send-email-emilio@elopez.com.ar>
Message-ID: <20130403214545.3383.95826@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Emilio L?pez (2013-03-27 14:20:36)
> Hi,
> 
> This patchset adds support for the main sunxi gates; namely, those found 
> on AXI, AHB, APB0 and APB1 clocks. The series depends on Maxime's UART 
> rework and on the basic sunxi clock driver by me.
> 
> Patches 1 and 2 implement the actual gate support, and patch 3 switches 
> the UARTs to use the correct gates now that they are available.
> 
> Patch 4 and 5 add clock support to our pinctrl driver, as we need to 
> keep the pio clock running for gpio to work.
> 
> Patch 6 drops the ignore flags; now that we have actual clock users that 
> will keep the important clocks running.
> 
> Patch 7 is an unrelated oneliner to remove an unnecesary kmalloc call.
> 
> The main changes from v1 are renamed compatible strings and a clarification
> on the documentation, see each individual patch for more details.
> 

Hi Emilio,

Which tree(s) did you want these patches to go through?

Regards,
Mike

> Thanks,
> 
> Emilio
> 
> Emilio L?pez (7):
>   clk: sunxi: Add support for AXI, AHB, APB0 and APB1 gates
>   arm: sunxi: Add clock definitions for AXI, AHB, APB0, APB1 gates
>   arm: sunxi: use the right clock phandles for UARTs
>   pinctrl: sunxi: add clock support
>   arm: sunxi: Add clock to pinctrl node
>   clk: sunxi: drop CLK_IGNORE_UNUSED
>   clk: sunxi: drop an unnecesary kmalloc
