From: khilman@linaro.org (Kevin Hilman)
Date: Tue, 14 Jan 2014 07:58:13 -0800
Subject: [PATCH 1/3] mmc: dw_mmc: use slot-gpio to handle cd pin
In-Reply-To: <1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
References: <1389278112-7099-1-git-send-email-zhangfei.gao@linaro.org>
 <1389278112-7099-2-git-send-email-zhangfei.gao@linaro.org>
Message-ID: <CAGa+x85awFYsrU9Gggirpaip3vggtSqu5GinVzss=nfNcp4nww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 9, 2014 at 6:35 AM, Zhangfei Gao <zhangfei.gao@linaro.org> wrote:
> Suggested by Jaehoon: Use slot-gpio to handle cd-gpio
> Add function dw_mci_of_get_cd_gpio to check "cd-gpios" from dts.
> mmc_gpio_request_cd and mmc_gpio_get_cd are used to handle cd pin
>
> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Acked-by: Jaehoon Chung <jh80.chung@samsung.com>

The Samsung Arndale board started failing boot from MMC root tests
starting with next-20140113 and I bisected it down to this patch.
Reverting this patch on top of next-20140114 gets Arndale booting
again from MMC.  Is there some supporting DT data that's missing for
Arndale?

Kevin
