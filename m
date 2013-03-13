From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Mar 2013 08:43:18 +0000
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdbCJd-ag1gLrJqJZ1D6+E5eX2tNuuNAtiKgtuBsxmrpmA@mail.gmail.com>
 <CAD6h2NRDJuGTTZ1B0iy__2SYYw7R18NRqQcwjsSvMJ3gA4E_WQ@mail.gmail.com>
Message-ID: <201303130843.18806.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 13 March 2013, Haojian Zhuang wrote:
> match table:
> {.compatible = "arm,sp804", .data = SP804_TIMER, },
> {.compaitlbe = "arm,integrator-timer", .data = INTEGRATOR_TIMER, },
> 
> sp804_get_clock_rate():
>     char dev_id_buf[ID_BUF_SIZE];
>     if (match->data)
>         snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
>     else
>         snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
>     clk = clk_get_sys(dev_id_buf, name);
> 
> sp804_dt_init_clk():
>     char dev_id_buf[ID_BUF_SIZE];
>     if (match->data)
>         snprintf(dev_id_buf, ID_BUF_SIZE, "ap_timer");
>     else
>         snprintf(dev_id_buf, ID_BUF_SIZE, "sp804");
>     lookup = clkdev_alloc(clk, name, dev_id_buf);
> 
> I think it won't break out code any more. Since most code are same, we
> could handle it in the same driver.
> 

The data member of struct of_device_id is a pointer, you could
point that directly to a const string containing the name, if that
is the only difference, or to another structure that describes
the other parameters.

	Arnd
